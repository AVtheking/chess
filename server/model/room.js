const mongoose = require('mongoose');
const playerSchema = require('./player');
const roomSchema = mongoose.Schema({
    roomName: {
        required: true,
        type: String,
        
    },
    occupancy: {
        type: Number,
        default: 2
    },
    players: [playerSchema],
    turn: playerSchema,
    turnIndex: {
        type: Number,
        default:0
    },
    isJoin: {
        type: Boolean,
        default: true
    },
});
const Room = mongoose.model("Room", roomSchema);
module.exports = Room;