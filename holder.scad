foldWidth = 9; 
holderWidth = 44;
Height = 40;
earbudsWidth = 30; 
scaleFactor = 1.9;


totalHeight = Height + foldWidth;
totalWidth = holderWidth + foldWidth;

module SidePannel() 
{
    translate([0, foldWidth, +scaleFactor])
    cube([2, Height, earbudsWidth - scaleFactor]);
    color("orange")
    translate([2,foldWidth,earbudsWidth-2])
    cube([10,Height,2]);

    color("silver")
    translate([12,foldWidth,earbudsWidth])
    triangle();
}

module magnetCutOut(xoffset,yoffset,zoffset) 
{
    xSize = 6.1;
    ySize = xSize *2;
    zSize = 2.9;
    translate([xoffset - xSize/2,yoffset- ySize,zoffset-zSize/2])
    cube([xSize,ySize,zSize]);
}

// This is the full back plate 
module BasePlate()
{    
    cube([totalWidth, totalHeight, 2]);
    cube([holderWidth, foldWidth, foldWidth]);
    translate([holderWidth ,0, 0])
    cube([foldWidth, Height + foldWidth, foldWidth]); 
}

module triangle()
{
    translate([0,0,-2])
    rotate(a=[-90,270,0])
    linear_extrude(height=Height)
    polygon(points = [[0,0],[2,0],[0,2]]);
}



module thing()
{
    translate([0,foldWidth,scaleFactor])
    cube([holderWidth,2,14 - scaleFactor]);
    color("green")
    translate([holderWidth,0,0])
    mirror(v=[totalWidth/2,0,0])
    {
        SidePannel();
    };
    
    SidePannel();
    
}


module roundedThing(roundRadious, sides)
{
    resize([holderWidth,Height,earbudsWidth])
    minkowski()
    {
        thing();
        sphere(roundRadious,$fn=sides);
    }
}

thing();
difference()
{
    BasePlate();
    translate([0,.01,0])
    magnetCutOut(holderWidth + foldWidth /2,totalHeight,foldWidth/2); 
}

/*minkowski()
    {
        thing();
        sphere(.155,$fn=10);
    };
*/
//BasePlate();
/*
difference()
{
    
    translate([-1,0,0])
    cube([1,100,50]);
}
BasePlate();
*/
