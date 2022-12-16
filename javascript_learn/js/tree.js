var treeData = {
    name: "Top Level",
    children: [
        {
            name: "Level 2: A",
            children: [
                {
                    name: "Son of A"
                },
                {
                    name: "Daughter of A"
                }
            ]
        },
        {
            name: "Level 2: B "
        }
    ]
}

// set up svg first
var margin = { top:20, right: 90, bottom: 20, left: 90}
var width = 960 - margin.left - margin.right;
var height = 500 - margin.top - margin.bottom;
    
var svg = d3
    .select(".container")
    .append("svg")
    .attr("width", width + margin.right + margin.left)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + ","+margin.top + ")")

var i = 0;
var duration = 750;
var root;


var treemap = d3.tree().size([height, width]);
root = d3.hierarchy(treeData, function (d){
    return d.children;
});
root.x0 = height/2; //makes sure our tree appears from the middle of the screen (is centered)
root.y0 = 0; 
console.log("root", root); 

update(root);

function update(source){
    var treeData = treemap(root);
    // nodes
    var nodes = treeData.descendants();
    //loop through the nodes
    nodes.forEach(function(d){
        d.y = d.depth * 180; // children had depth so we're using their depth to set the y value on the nodes so that they're contaned nicely within the graph
    });
    var node = svg.selectAll("g.node").data(nodes, function(d){
        return d.id || (d.id * ++ i);
    })

    // want nodes to start at parent position
    var nodeEnter = node
    .enter()
    .append("g")
    .attr("class", "node")
    .attr("transform", function(d){
        return "translate(" + source.y0 + ", " + source.x0 + ")";
    })
    .on("click", click);



}

