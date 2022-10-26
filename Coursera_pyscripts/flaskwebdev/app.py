from distutils.log import debug
from turtle import home
from flask import Flask #initialize flask
from views import views

app = Flask(__name__) #initializes application
app.register_blueprint(views, url_prefix="/views")

#creating views/routes
#routes are endpoints of the url
#created in a separate file in our case the views.py file. 
# mainly to avoid clutering the app file



if __name__ == '__main__':
    app.run(debug=True, port=8000)