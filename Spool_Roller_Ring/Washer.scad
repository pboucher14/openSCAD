/* Washer by Mike Thompson */

inner_diameter=8;
outer_diameter=14;
thickness=2;

difference()
{
	cylinder(r=outer_diameter/2,h=thickness,$fn=100);
	cylinder(r=inner_diameter/2,h=thickness,$fn=100);
}