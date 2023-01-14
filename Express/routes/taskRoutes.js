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

router.get('/:uid/completed', (req, res) => {
    Task.find({
        uid : req.params.uid, finished : true
    })
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.get('/:uid/uncompleted', (req, res) => {
    Task.find({
        uid : req.params.uid, finished : false
    })
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.put('/', bodyParser.json(), function(req, res) {
    const updatedTask = req.body;
    const taskId = req.body.taskId
    console.log(req.body)
    res.set('Content-Type', 'application/json');  // Set the Content-Type header
    Task.findOneAndUpdate({ taskId: taskId }, updatedTask, { new: true })
      .then((result) => {
        console.log(updatedTask)
        res.send(result)
      })
      .catch((err) => {
        console.log(err)
      })
  });

router.post('/create/', (req, res) => {
    const task = new Task({
        title: req.body.title,
        description: req.body.description,
        priority: req.body.priority,
        time: req.body.time,
        tracked: req.body.tracked,
        finished : req.body.finished,
        uid: req.body.uid,
        taskId: req.body.taskId
      })
    console.log(req.body)
    console.log(task)
    task.save()
    .then((results) => {
        console.log(results)
        res.send(results)
    })
    .catch(err => {
        console.log(err)
        res.status(400).json({ message: 'Error saving task to the database' })})
       
})

router.delete('/delete/:taskId', (req, res) => {
    console.log(req.params.taskId)
    Task.deleteOne({
        taskId : req.params.taskId
    })
    .then((result) => {
        console.log(result)
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
        res.status(400).json({ message: 'Error deleting task from the database' })
    })
})

module.exports = router