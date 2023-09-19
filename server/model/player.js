const mongoose = require('mongoose');
const playerSchema = mongoose.Schema({
    nickname: {
        type: String,
        required: true,
        trim: true,
    },
    socketId: {
        type: String,
        
    },
    playertype: {
        type: String,  
        required:true,
    },

});
module.exports = playerSchema;