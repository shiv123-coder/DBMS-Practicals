from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Car(db.Model):
    __tablename__ = 'Car'
    car_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    make = db.Column(db.String(50), nullable=False)
    model = db.Column(db.String(50), nullable=False)
    year = db.Column(db.Integer, nullable=False)
    daily_rate = db.Column(db.Numeric(10, 2), nullable=False)
    status = db.Column(db.Enum('available', 'rented', 'maintenance'), default='available')

    # Relationships
    bookings = db.relationship('Booking', backref='car', cascade='all, delete')
    maintenances = db.relationship('Maintenance', backref='car', cascade='all, delete')


class Customer(db.Model):
    __tablename__ = 'Customer'
    cust_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    phone = db.Column(db.String(15))
    address = db.Column(db.String(255))

    # Relationship
    bookings = db.relationship('Booking', backref='customer', cascade='all, delete')


class Booking(db.Model):
    __tablename__ = 'Booking'
    booking_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    cust_id = db.Column(db.Integer, db.ForeignKey('Customer.cust_id', ondelete='CASCADE'), nullable=False)
    car_id = db.Column(db.Integer, db.ForeignKey('Car.car_id', ondelete='CASCADE'), nullable=False)
    start_date = db.Column(db.Date, nullable=False)
    end_date = db.Column(db.Date, nullable=False)
    total_price = db.Column(db.Numeric(10, 2), nullable=False)


class Maintenance(db.Model):
    __tablename__ = 'Maintenance'
    maintenance_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    car_id = db.Column(db.Integer, db.ForeignKey('Car.car_id', ondelete='CASCADE'), nullable=False)
    service_date = db.Column(db.Date, nullable=False)
    details = db.Column(db.String(255))
    cost = db.Column(db.Numeric(10, 2))
