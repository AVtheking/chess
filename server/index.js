// console.log("hello");
const express = require('express');
const app = express();
const mongoose = require('mongoose');
const http = require('http');
const server = http.createServer(app);
// const io = require('socket.io')(server);
const { Server } = require("socket.io");
const io = new Server(server);
const PORT = 3000;
const Room = require('./model/room');
const authRouter = require('./routes/auth');


const DB = "mongodb+srv://Ankit:Ankit123@chess.yrpq0tb.mongodb.net/?retryWrites=true&w=majority"
app.use(express.json());

app.use(authRouter);
io.on("connection", (socket) => {
    console.log("connected", socket.id);
<<<<<<< HEAD
    socket.on("createRoom", async ({ nickname }) => {
        try {
            // console.log(nickname);
            const existingRoom = await Room.findOne({ roomName });
            if (existingRoom) {
               return  socket.emit("error","Room already exists")
            }
            let room = new Room();
=======
    socket.on("createRoom", async ({ roomName,nickname }) => {
        try {
            console.log(nickname);
            const existingRoom = await Room.findOne({ roomName });
            if (existingRoom) {
                console.log("Room already exists");
                socket.emit("error", "Room already exists");
                return;
            }
            let room = new Room({
                roomName
            });
>>>>>>> 7efa588 (ui improved)
            let player = {
                socketId: socket.id,
                nickname,
                playertype:"w"
            }
            room.players.push(player);
            room = await room.save();
            const roomId = room._id.toString();
            socket.join(roomId);
            io.to(roomId).emit("createRoomSuccess", room);
        } catch (e) {
            console.error(e);
        }
    });

<<<<<<< HEAD
    socket.on("joinRoom", async ({ nickname, roomId }) => {
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit("error", "Please enter the valid room id");
                console.log("please enter room id");
                return; 
            }
            
            let room = await Room.findById(roomId);
=======
    socket.on("joinRoom", async ({ nickname, roomName }) => {
        try {
            let room = await Room.findOne({roomName});
>>>>>>> 7efa588 (ui improved)
            if (room.isJoin)
            {
                let player = {
                    socketId: socket.id,
                    nickname,
                    playertype:'b'


<<<<<<< HEAD
                }
=======

                }
                const roomId = room._id.toString;
>>>>>>> 7efa588 (ui improved)
                room.players.push(player);
                socket.join(roomId);
                room.isJoin = false;
                room = await room.save();

                io.to(roomId).emit("joinRoomSuccess", room);
<<<<<<< HEAD
                io.to(roomId).emit("updatePlayers", room);
=======
                io.to(roomId).emit("updatePlayers", room.players);
>>>>>>> 7efa588 (ui improved)
                io.to(roomId).emit("updateRoom", room);


            }
            else {
                socket.emit("error", "The game is in progress ,please try again ");
                
            }

        } catch (e) {
            console.error(e);
        }
    })
    socket.on("move", async ({ roomId,fen}) => {
        
        try {
            
           
            socket.join(roomId);
            io.to(roomId).emit("movesListner", fen);
            
        }
        catch (e) {
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





