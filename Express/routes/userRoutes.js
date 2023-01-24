const express = require('express')
const router = express.Router()
const Task = require('../models/task')
const User = require('../models/user')
const bodyParser = require('body-parser');

router.get('/', (req, res) => {
    User.find()
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.post('/create', (req, res) => {
    const user = new User({
        firstName: req.body.first_name,
        lastName: req.body.last_name,
        username: req.body.username,
        uid: req.body.uid,
        totalTasks : req.body.total_tasks,
        doneTasks : req.body.done_tasks, 
        coins : req.body.coins,
        background1 : req.body.background1,
        background2 : req.body.background2,
        background3 : req.body.background3,
        background4 : req.body.background4,
        avatar1 : req.body.avatar1,
        avatar2 : req.body.avatar2,
        avatar3 : req.body.avatar3,
        avatar4 : req.body.avatar4
      })
    console.log(user)
    console.log(req.body)
    user.save()
    .then((results) => {
        console.log(results)
        res.send(results)
    })
    .catch(err => {
        res.status(400).json({ message: 'Error saving user to the database' })})
})

router.put('/', bodyParser.json(), function(req, res) {
    const updatedUser = req.body;
    const uid = req.body.uid;
    console.log(updatedUser)
    console.log(req.body)
    User.findOneAndUpdate({ uid: uid }, updatedUser, { new: true })
      .then((result) => {
        res.send(result)
      })
      .catch((err) => {
        console.log(err)
      })
  });

router.get('/user/:id', (req, res) => {
    User.find({
        uid : req.params.id
    })
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

module.exports = router
