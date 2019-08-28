# (ascii art below courtesy of http://patorjk.com/software/taag)

#################################################
#dependencies
#################################################

#sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

#flask
from flask import Flask, jsonify

#################################################
#prep database
#################################################
engine = create_engine("sqlite:///resources/hawaii.sqlite")

#reflect existing db
Base = automap_base()
#reflect tables
Base.prepare(engine, reflect=True)

#refs to tables
Measurement = Base.classes.measurement
Station = Base.classes.station

#################################################
#flask
#################################################
app = Flask(__name__)

#################################################
#routes
#################################################

#home route
@app.route("/")
def home():
    '''All available api routes.'''
    return (
        '<div style="font-family:courier; color:#0b5345; text-align:center; padding:175px">'
        
        '███████╗██╗...██╗██████╗.███████╗███████╗....██╗...██╗██████╗.██╗<br/>'
        '██╔════╝██║...██║██╔══██╗██╔════╝██╔════╝....██║...██║██╔══██╗██║<br/>'
        '███████╗██║...██║██████╔╝█████╗..███████╗....██║...██║██████╔╝██║<br/>'
        '╚════██║██║...██║██╔══██╗██╔══╝..╚════██║....██║...██║██╔═══╝.╚═╝<br/>'
        '███████║╚██████╔╝██║..██║██║.....███████║....╚██████╔╝██║.....██╗<br/>'
        '╚══════╝.╚═════╝.╚═╝..╚═╝╚═╝.....╚══════╝.....╚═════╝.╚═╝.....╚═╝<br/>'

        '.█████╗.██████╗.██╗<br/>'
        '██╔══██╗██╔══██╗██║<br/>'
        '███████║██████╔╝██║<br/>'
        '██╔══██║██╔═══╝.██║<br/>'
        '██║..██║██║.....██║<br/>'
        '╚═╝..╚═╝╚═╝.....╚═╝<br/>'
        
        '<h3>Available Routes:</h3>'

        '<b><u>Data</u>:</b><br/>'
        '/api/v1.0/precipitation<br/>'
        '/api/v1.0/stations<br/>'
        '/api/v1.0/tobs<br/><br/>'
        '<b><u>Date Search (Temperature)</u>:</b><br/>'
        '/api/v1.0/start_date<br/>'
        '/api/v1.0/start_date/end_date<br/><br/>'
        '(date format: <i>yyyy-mm-dd)</i>'

        '<br/><br/>'
        '<small>-Andrew J. Morrison<br/>'
        'UC Davis Data Analytics Bootcamp (June 2019)</small></div>'
    )

#precipitation route
@app.route("/api/v1.0/precipitation")
def precipitation():
    
    #open session
    session = Session(engine)

    '''return list of precipitation values'''
    #query precipitation vaues
    results = session.query(Measurement.date, Measurement.prcp, Measurement.station).all()
    
    #empty dict
    dict_prcp = {}
    
    #loop--date as key
    for row in results:
        dict_prcp[row.date] = row.prcp

    #close session
    session.close()
    
    #return compl. dict
    return jsonify(dict_prcp)

#station route
@app.route("/api/v1.0/stations")
def stations():
    
    #open session
    session = Session(engine)

    '''return list of stations'''
    #query stations
    results = session.query(Station.id, Station.station, Station.name,\
                           Station.latitude, Station.longitude, Station.elevation).all()

    #close session
    session.close()

    #dictionary from the each row and add to list 
    stations_all = []
   
    #loop
    for row in results:
        
        dict_stations = {}
        dict_stations['station'] = row.station
        dict_stations['name'] = row.name
        dict_stations['latitude'] = row.latitude
        dict_stations['longitude'] = row.longitude
        dict_stations['elevation'] = row.elevation
        stations_all.append(dict_stations)
    
    #return full list
    return jsonify(stations_all)

#tobs route
@app.route('''/api/v1.0/tobs''')
def tobs():
    
    #open session
    session = Session(engine)

    '''return last year of tobs'''
    #query
    results = session.query(Measurement.tobs, Measurement.date).\
                            filter(Measurement.date > '2016-08-23').all()
    
    #close session
    session.close()

    # Create a dictionary from the row data and append to a list of all_passengers
    dict_tobs = {}
    
    for row in results:
        dict_tobs[row.date] = row.tobs

    return jsonify(dict_tobs)

#date search route (start only)
@app.route('''/api/v1.0/<start>''')
def start(start):
    
    #open session
    session = Session(engine)   

    '''return list of temps for range'''
    #query
    results = session.query(func.min(Measurement.tobs),\
                            func.avg(Measurement.tobs),\
                            func.max(Measurement.tobs)).\
                    filter(Measurement.date >= start).all()
    
    #close session
    session.close()
    
    for row in results:
        
        dict_start = {}
        dict_start['min'] = row[0]
        dict_start['avg'] = row[1]
        dict_start['max'] = row[2]

    return jsonify(dict_start)

#date search route (start & end)
@app.route('''/api/v1.0/<start>/<end>''')
def start_end(start, end):
    
    #open session
    session = Session(engine)   

    '''return list of temps for range'''
    #query
    results = session.query(func.min(Measurement.tobs),\
                            func.avg(Measurement.tobs),\
                            func.max(Measurement.tobs)).\
                    filter(Measurement.date >= start).\
                    filter(Measurement.date <= end).all()
    
    #close session
    session.close()
    
    for row in results:
        
        dict_start_end = {}
        dict_start_end['min'] = row[0]
        dict_start_end['avg'] = row[1]
        dict_start_end['max'] = row[2]

    return jsonify(dict_start_end)

if __name__ == '__main__':
    app.run(debug=True)