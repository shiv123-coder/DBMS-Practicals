mongo

use comp

db.createCollection("employees")

db.employees.insertOne({
  name: "Ajay",
  age: 28,
  department: "HR",
  salary: 35000
})

db.employees.insertMany([
  { name: "Boby", age: 32, department: "Sales", salary: 40000 },
  { name: "Charlie", age: 29, department: "Sales", salary: 40000 },
  { name: "Dlia", age: 35, department: "Engineering", salary: 60000 }
])

db.employees.find().pretty()

db.employees.find({
  $or: [
    { department: "Engineering" },
    { department: "Sales" }
  ]
})

db.employees.find({
  $and: [
    { age: { $gt: 30 } },
    { department: "Engineering" }
  ]
})

db.employees.updateOne(
  { name: "Ajay" },
  { $set: { salary: 37000 } }
)

db.employees.updateMany(
  { department: "Engineering" },
  { $inc: { salary: 1000 } }
)

db.employees.replaceOne(
  { name: "Boby" },
  { name: "Robin", age: 41, email: "robin@abc.com" }
)

db.employees.updateMany(
  {},
  { $set: { salary: 10000 } }
)

db.employees.deleteOne({
  _id: ObjectId("68db58bb2c621b2d71ab70e6")
})

db.employees.deleteMany({ likes: 2 })

db.employees.drop()

db.employees.save({ _id: 1, name: "Diana" })
db.employees.save({ _id: 2, name: "Tania" })
db.employees.save({ _id: 3, name: "Saniya" })

db.employees.updateOne({ _id: 1 }, { $set: { likes: 2 } })
db.employees.updateOne({ _id: 2 }, { $set: { likes: 2 } })
db.employees.updateOne({ _id: 3 }, { $set: { likes: 2 } })

db.employees.deleteOne({ _id: 1 })
db.employees.deleteMany({ likes: 2 })

db.employees.find().pretty()

db.employees.createIndex({ department: 1 })
db.employees.createIndex({ department: 1, salary: -1 })
db.employees.dropIndex({ department: 1 })
db.employees.getIndexes()

db.employees.aggregate([
  { $group: { _id: "$department", totalEmployees: { $sum: 1 } } }
])

db.employees.aggregate([
  { $group: { _id: "$department", averageSalary: { $avg: "$salary" } } }
])

db.employees.aggregate([
  {
    $group: {
      _id: null,
      minSalary: { $min: "$salary" },
      maxSalary: { $max: "$salary" }
    }
  }
])

db.employees.aggregate([
  { $group: { _id: "$department", employees: { $push: "$name" } } }
])

db.employees.aggregate([
  { $sort: { salary: -1 } }
])

db.employees.aggregate([
  { $sort: { salary: -1 } },
  { $limit: 3 }
])

db.employees.find().pretty()
