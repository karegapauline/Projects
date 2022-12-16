d3.csv('food.csv', function(data){
    return{
        "food": data.Food,
        "deliciousness": data.Deliciousness
    }
}).then(function(dataset){
    var body = d3.select('body');
    body.selectAll('p')
        .data(dataset)
        .enter()
        .append('p')
        .text(function (d){
            return d.food;
        })
        .style('color', function(d) {
            return "rgb(0, " + d.deliciousness* 25 +", 255)"
        })

});