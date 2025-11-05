mongo
// 1. Use database (create if not exists)
use test;

// 2. Create collection (skip if already exists)
db.createCollection('students'); // if collection exists, MongoDB shows "NamespaceExists"

// 3. Insert documents (fixed syntax and corrected city names)
db.students.insertMany([
  { name: "Amit", subject: "Math", marks: 85, city: "Delhi" },
  { name: "Riya", subject: "Science", marks: 90, city: "Delhi" },
  { name: "Karan", subject: "Math", marks: 70, city: "Mumbai" },
  { name: "Neha", subject: "Science", marks: 80, city: "Mumbai" },
  { name: "Priya", subject: "Math", marks: 95, city: "Delhi" }
]);

// 4. Display all documents
db.students.find(); 

// Basic Aggregation

// 5. Total marks by subject
db.students.aggregate([
  { $group: { _id: "$subject", totalMarks: { $sum: "$marks" } } }
]);

// 6. Average marks per subject
db.students.aggregate([
  { $group: { _id: "$subject", avgMarks: { $avg: "$marks" } } }
]);

// 7. Students with marks > 80
db.students.aggregate([
  { $match: { marks: { $gt: 80 } } }
]);

// 8. Sort subjects by average marks ascending
db.students.aggregate([
  { $group: { _id: "$subject", avgMarks: { $avg: "$marks" } } },
  { $sort: { avgMarks: 1 } }
]);

// Multi-stage Aggregation

// 9. Average marks per subject per city
db.students.aggregate([
  { $group: { _id: { city: "$city", subject: "$subject" }, avgMarks: { $avg: "$marks" } } }
]);

// 10. Projection: show only city, subject, avgMarks
db.students.aggregate([
  { $group: { _id: { city: "$city", subject: "$subject" }, avgMarks: { $avg: "$marks" } } },
  { $project: { _id: 0, city: "$_id.city", subject: "$_id.subject", avgMarks: 1 } }
]);

// 11. Top 2 scoring subjects overall
db.students.aggregate([
  { $group: { _id: "$subject", totalMarks: { $sum: "$marks" } } },
  { $sort: { totalMarks: -1 } },
  { $limit: 2 }
]);

// 12. $unwind example
db.students.insertOne({ name: "Sam", hobbies: ["reading", "music", "coding"] });
db.students.aggregate([{ $unwind: "$hobbies" }]);

// Indexing

// 13. Create single-field index on city
db.students.createIndex({ city: 1 });

// 14. View all indexes
db.students.getIndexes();

// 15. Create compound index on city and subject
db.students.createIndex({ city: 1, subject: 1 });

// 16. Drop index on city (if exists)
db.students.dropIndex({ city: 1 });

// 17. Check index usage in a query
db.students.find({ city: "Delhi" }).explain("executionStats");

// 18. Create text index on name
db.students.createIndex({ name: "text" });

// 19. Search using text index
db.students.find({ $text: { $search: "Priya" } });

// 20. Create hashed index on name
db.students.createIndex({ name: "hashed" });

// Aggregation + Index Combined

// 21. Total marks for students in Delhi using index
db.students.createIndex({ city: 1 });
db.students.aggregate([
  { $match: { city: "Delhi" } },
  { $group: { _id: "$subject", total: { $sum: "$marks" } } }
]);

// 22. Verify index usage in aggregation
db.students.aggregate([
  { $match: { city: "Delhi" } },
  { $group: { _id: "$subject", total: { $sum: "$marks" } } }
]).explain("executionStats");
