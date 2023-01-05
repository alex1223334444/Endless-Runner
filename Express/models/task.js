//title, description, priority 0-4, time, tracking bool
const mongoose = require('mongoose')
const Schema = mongoose.Schema

const taskSchema = new Schema({
    title: {
        type: String,
        required : true
    },
    description: {
        type: String,
        required : true
    },
    priority: {
        type: Number,
        required : true
    },
    time: {
        type : String, 
        required: true
    },
    tracked: {
        type: Boolean,
        required: true
    },
    finished : {
        type : Boolean,
        required: true
    },
    uid: {
        type : String, 
        required: true
    }
}, {timestamps: true})

 const Task = mongoose.model('Task', taskSchema)

 module.exports = Task