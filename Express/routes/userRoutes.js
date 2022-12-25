const express = require('express')
const router = express.Router()
const Task = require('../models/task')
const User = require('../models/user')

router.get('/', (req, res) => {
    User.find()
    .then((result) => {
        res.send(result)
    })
    .catch((err) => {
        console.log(err)
    })
})

router.get('/create', (req, res) => {
    const user = new User({
        firstName : 'User',
        lastName : 'User',
        username : 'user',
        uid : '0', 
    })

    user.save()
    .then((results) => {
        res.send(results)
    })
    .catch((err)=>{
        console.log(err)
    })
})


/*router.put('/user/:id/task', async (req, res) => {
    try {
      await User.findOneAndUpdate({uid : req.params.id} , {
          tasks: req.body
      },{returnDocument : true});
      // Send response in here
      res.send('Item Updated!')

    } catch(err) {
        console.error(err.message);
        res.send(400).send('Server Error');
    }
});*/


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
