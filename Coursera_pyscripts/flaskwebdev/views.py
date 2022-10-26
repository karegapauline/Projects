from flask import Blueprint, render_template


# need to define blueprint

views = Blueprint(__name__, "views")

@views.route("/")
def home():
    return render_template("index.html", name="Pauline")
