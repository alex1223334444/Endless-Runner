const express = require('express')
const router = express.Router()
const Task = require('../models/task')
const User = require('../models/user')
const date = new Date()
const bodyParser = require('body-parser');


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

router.put('/:uid/:title', bodyParser.json(), function(req, res) {
    const uid = req.params.uid;
    const title = req.params.title;
    const updatedTask = req.body;
    console.log(req.body)
    res.set('Content-Type', 'application/json');  // Set the Content-Type header
    Task.findOneAndUpdate({ uid: uid, title: title }, updatedTask, { new: true })
      .then((result) => {
        console.log(updatedTask)
        console.log(uid, title)

        res.send(result)
      })
      .catch((err) => {
        console.log(err)
      })
  });

router.post('/create/:id', (req, res) => {
    const task = new Task({
        title : 'Homeworks',
        description : 'do chores',
        priority : 1,
        time: date,
        tracked : false,
        finished: false,
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