const mongoose = require('mongoose');
const playerSchema = require('./player');
const roomSchema = mongoose.Schema({
<<<<<<< HEAD
=======
    roomName: {
        required: true,
        type: String,
        
    },
>>>>>>> 7efa588 (ui improved)
    occupancy: {
        type: Number,
        default: 2
    },
    players: [playerSchema],
    isJoin: {
        type: Boolean,
        default: true
    },
});
const Room = mongoose.model("Room", roomSchema);
module.exports = Room;