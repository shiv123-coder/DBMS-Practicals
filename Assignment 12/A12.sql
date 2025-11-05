//Step 1: Use database 'comp'
use comp

// Step 2: Create the 'sales' collection
db.createCollection("sales")

// Step 3: Insert sample documents into 'sales' collection
db.sales.insertMany([
  { _id: 1, product: "Laptop", price: 70000, quantity: 2 },
  { _id: 2, product: "Mouse", price: 500, quantity: 5 },
  { _id: 3, product: "Keyboard", price: 1500, quantity: 3 },
  { _id: 4, product: "Laptop", price: 70000, quantity: 1 },
  { _id: 5, product: "Mouse", price: 500, quantity: 2 }
])

// Step 4: MapReduce - Total Sales per Product
var mapTotal = function() {
  emit(this.product, this.price * this.quantity);
};

// Reduce function sums all total sales for the same product
var reduceTotal = function(key, values) {
  return Array.sum(values);
};

// Execute MapReduce and store results in 'total_sales_per_product' collection
db.sales.mapReduce(
  mapTotal,
  reduceTotal,
  { out: "total_sales_per_product" }
);

// View Total Sales per Product results
db.total_sales_per_product.find()

// Step 5: MapReduce - Count Sales per Product
var mapCount = function() {
  emit(this.product, 1);
};

// Reduce function sums all counts for the same product
var reduceCount = function(key, values) {
  return Array.sum(values);
};

// Execute MapReduce and store results in 'sales_count' collection
db.sales.mapReduce(
  mapCount,
  reduceCount,
  { out: "sales_count" }
);

// View Sales Count per Product results
db.sales_count.find()
