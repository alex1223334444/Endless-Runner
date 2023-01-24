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
    },
    totalTasks : {
        type : Number, 
        required: true
    },
    doneTasks : {
        type : Number, 
        required: true
    },
    coins : {
        type : Number, 
        required: true
    },
    background1 : {
        type: Number,
        required: true
    },
    background2 : {
        type: Number,
        required: true
    },
    background3 : {
        type: Number,
        required: true
    },
    background4 : {
        type: Number,
        required: true
    },
    avatar1 : {
        type: Number,
        required: true
    },
    avatar2 : {
        type: Number,
        required: true
    },
    avatar3 : {
        type: Number,
        required: true
    },
    avatar4 : {
        type: Number,
        required: true
    }
}, {timestamps: true})

 const User = mongoose.model('User', userSchema)

 module.exports = User