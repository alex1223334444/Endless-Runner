const mongoose = require('mongoose')
const task = require('./task')

const Schema = mongoose.Schema

const userSchema = new Schema({
    firstName: {
        type: String,
        required : true
    },
    lastName: {
        type: String,
        required : true
    },
    username: {
        type: String,
        required : true
    },
    uid: {
        type : String, 
        required: true
    }/*,
    tasks: {
        type: Schema.Types.ObjectId,
        ref: "Task",
        required: true,
        default : []
    }*/
}, {timestamps: true})

 const User = mongoose.model('User', userSchema)

 module.exports = User