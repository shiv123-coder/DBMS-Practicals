from flask import Flask, render_template, request, redirect, url_for, flash
from models import db, Car, Customer, Booking, Maintenance

app = Flask(__name__)
app.secret_key = 'dev-secret-key'

# ---------------- DATABASE CONFIG ----------------
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:1234@localhost/car_management'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

# ---------------- HOME ----------------
@app.route('/')
def index():
    return render_template('index.html')

# ---------------- CARS ----------------
@app.route('/cars')
def cars():
    cars = Car.query.all()
    return render_template('cars.html', cars=cars)

@app.route('/add_car', methods=['GET', 'POST'])
def add_car():
    if request.method == 'POST':
        car = Car(
            make=request.form['make'],
            model=request.form['model'],
            year=request.form['year'],
            daily_rate=request.form['daily_rate']
        )
        db.session.add(car)
        db.session.commit()
        flash('Car added successfully!', 'success')
        return redirect(url_for('cars'))
    return render_template('add_car.html')

@app.route('/edit_car/<int:car_id>', methods=['GET', 'POST'])
def edit_car(car_id):
    car = Car.query.get_or_404(car_id)
    if request.method == 'POST':
        car.make = request.form['make']
        car.model = request.form['model']
        car.year = request.form['year']
        car.daily_rate = request.form['daily_rate']
        db.session.commit()
        flash('Car updated successfully!', 'info')
        return redirect(url_for('cars'))
    return render_template('edit_car.html', car=car)

@app.route('/delete_car/<int:car_id>')
def delete_car(car_id):
    car = Car.query.get_or_404(car_id)
    db.session.delete(car)
    db.session.commit()
    flash('Car deleted successfully!', 'danger')
    return redirect(url_for('cars'))

# ---------------- CUSTOMERS ----------------
@app.route('/customers')
def customers():
    customers = Customer.query.all()
    return render_template('customers.html', customers=customers)

@app.route('/add_customer', methods=['GET', 'POST'])
def add_customer():
    if request.method == 'POST':
        cust = Customer(
            name=request.form['name'],
            email=request.form['email'],
            phone=request.form['phone'],
            address=request.form['address']
        )
        db.session.add(cust)
        db.session.commit()
        flash('Customer added successfully!', 'success')
        return redirect(url_for('customers'))
    return render_template('add_customer.html')

@app.route('/edit_customer/<int:cust_id>', methods=['GET', 'POST'])
def edit_customer(cust_id):
    cust = Customer.query.get_or_404(cust_id)
    if request.method == 'POST':
        cust.name = request.form['name']
        cust.email = request.form['email']
        cust.phone = request.form['phone']
        cust.address = request.form['address']
        db.session.commit()
        flash('Customer updated successfully!', 'info')
        return redirect(url_for('customers'))
    return render_template('edit_customer.html', customer=cust)

@app.route('/delete_customer/<int:cust_id>')
def delete_customer(cust_id):
    cust = Customer.query.get_or_404(cust_id)
    db.session.delete(cust)
    db.session.commit()
    flash('Customer deleted successfully!', 'danger')
    return redirect(url_for('customers'))

# ---------------- BOOKINGS ----------------
@app.route('/bookings')
def bookings():
    bookings = Booking.query.all()
    return render_template('bookings.html', bookings=bookings)

@app.route('/add_booking', methods=['GET', 'POST'])
def add_booking():
    customers = Customer.query.all()
    cars = Car.query.filter(Car.status != 'rented').all()

    if request.method == 'POST':
        booking = Booking(
            cust_id=request.form['cust_id'],
            car_id=request.form['car_id'],
            start_date=request.form['start_date'],
            end_date=request.form['end_date'],
            total_price=request.form['total_price']
        )
        db.session.add(booking)
        car = Car.query.get(request.form['car_id'])
        car.status = 'rented'
        db.session.commit()
        flash('Booking added successfully!', 'success')
        return redirect(url_for('bookings'))

    return render_template('add_booking.html', customers=customers, cars=cars)

@app.route('/delete_booking/<int:booking_id>')
def delete_booking(booking_id):
    booking = Booking.query.get_or_404(booking_id)
    db.session.delete(booking)
    db.session.commit()
    flash('Booking deleted successfully!', 'danger')
    return redirect(url_for('bookings'))

# ---------------- MAINTENANCE ----------------
@app.route('/maintenance')
def maintenance():
    maintenance = Maintenance.query.all()
    return render_template('maintenance.html', maintenance=maintenance)

@app.route('/add_maintenance', methods=['GET', 'POST'])
def add_maintenance():
    cars = Car.query.all()
    if request.method == 'POST':
        m = Maintenance(
            car_id=request.form['car_id'],
            service_date=request.form['service_date'],
            details=request.form['details'],
            cost=request.form['cost']
        )
        db.session.add(m)
        db.session.commit()
        flash('Maintenance record added successfully!', 'success')
        return redirect(url_for('maintenance'))
    return render_template('add_maintenance.html', cars=cars)

@app.route('/edit_maintenance/<int:maintenance_id>', methods=['GET', 'POST'])
def edit_maintenance(maintenance_id):
    m = Maintenance.query.get_or_404(maintenance_id)
    if request.method == 'POST':
        m.car_id = request.form['car_id']
        m.service_date = request.form['service_date']
        m.details = request.form['details']
        m.cost = request.form['cost']
        db.session.commit()
        flash('Maintenance updated successfully!', 'info')
        return redirect(url_for('maintenance'))
    return render_template('edit_maintenance.html', m=m)

@app.route('/delete_maintenance/<int:maintenance_id>')
def delete_maintenance(maintenance_id):
    m = Maintenance.query.get_or_404(maintenance_id)
    db.session.delete(m)
    db.session.commit()
    flash('Maintenance deleted successfully!', 'danger')
    return redirect(url_for('maintenance'))

# ---------------- RUN APP ----------------
if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)
