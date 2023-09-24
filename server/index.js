// console.log("hello");
const express = require('express');
const app = express();
const mongoose = require('mongoose');
const http = require('http');
const server = http.createServer(app);
// const io = require('socket.io')(server);
const { Server } = require("socket.io");
const io = new Server(server);
const PORT = process.env.PORT || 3000;
const Room = require('./model/room');
const authRouter = require('./routes/auth');


const DB = "mongodb+srv://user1:1234@chess.yrpq0tb.mongodb.net/?retryWrites=true&w=majority"
app.use(express.json());

app.use(authRouter);
io.on("connection", (socket) => {
    console.log("connected", socket.id);
    socket.on("createRoom", async ({ roomName,nickname }) => {
        try {
            console.log(nickname);
            const existingRoom = await Room.findOne({ roomName });
            if (existingRoom) {
                console.log("Room already exists");
                socket.emit("error", "Room already exists");

            }
            else
           { let room = new Room({
                roomName
            });
            let player = {
                socketId: socket.id,
                nickname,
                playertype:"w"
            }
            room.turn = player;
            room.players.push(player);
            room = await room.save();
            // const roomId = room._id.toString();
            socket.join(roomName);
            io.to(roomName).emit("createRoomSuccess", room);}
        } catch (e) {
            console.error(e);
        }
    })

    socket.on("joinRoom", async ({ nickname, roomName }) => {
        try {
            let room = await Room.findOne({roomName});
            if (room.isJoin)
            {
                let player = {
                    socketId: socket.id,
                    nickname,
                    playertype:'b'



                }
                // const roomId = room._id.toString;
                socket.join(roomName);
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();

                io.to(roomName).emit("joinRoomSuccess", room);
                io.to(roomName).emit("updatePlayers", room.players);
                io.to(roomName).emit("updateRoom", room);


            }
            else {
                socket.emit("error", "The game is in progress ,please try again ");
                
            }

        } catch (e) {
            console.error(e);
        }
    })
    socket.on("move", async ({ roomName,fen}) => {
        
        try {
            socket.join(roomName);
            let room = await Room.findOne({ roomName });
            if (room.turnIndex == 0) {
                room.turnIndex = 1;
                room.turn = room.players[1];
            }
            else {
                room.turnIndex = 0;
                room.turn=room.players[0]
            }
            room = await room.save();
            io.to(roomName).emit("movesListner", {
                fen,
                room,

            });
            
        }
        catch (e) {
            console.log(e);
        }
    })
    socket.on("checkmate", async ({ roomName, player }) => {
        try {
            socket.join(roomName);
            let room = await Room.deleteOne({ roomName });
            // room = await room.save();S
            io.to(roomName).emit("endgame", player);
        } catch (e) {
            console.log(e);
        }
    })
});

mongoose.connect(DB).then(() => {
    console.log(`Connected to mongoDB`)
}).catch(e => {
    console.log(e);
});

server.listen(PORT, "0.0.0.0", async () => {
    console.log("Server started  and running on port " + PORT);
})





