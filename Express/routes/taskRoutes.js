const express = require('express')
const router = express.Router()
const Task = require('../models/task')
const User = require('../models/user')
const date = new Date()

router.get('/', (req, res) => {
    Task.find()
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.get('/:uid', (req, res) => {
    Task.find({
        uid : req.params.uid
    })
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.post('/create/:id', (req, res) => {
    const task = new Task({
        title : 'Workout',
        description : 'Go to the gym',
        priority : 0,
        time: date,
        tracked : false,
        uid : req.params.id, 
    })

    task.save()
    .then((results) => {
        res.send(results)
    })
    .catch((err)=>{
        console.log(err)
    })
})



module.exports = router