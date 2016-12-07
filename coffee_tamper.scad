//! Parametric coffee tamper.
//! Consists of base, handle and decorative sphere on top.
//! @param h total height including base, handle and decorative sphere on top
//! @param bd base diameter
//! @param br base radius
//! @param bh base height
//! @param brr base rounding radius
//! @param sd decorative sphere diameter
//! @param sr decorative sphere radius
module coffee_tamper(h,
                     bd=undef, br=undef,
                     bh=undef, brr=undef,
                     hd=undef, hr=undef,
                     sd=undef, sr=undef)
{
  default_bh = 5;
  base_r = br != undef ? br : bd / 2;
  base_h = bh != undef ? bh : default_bh;
  base_rr = brr != undef ? brr : base_h / 2;
  handle_r = hr != undef ? hr : hd / 2 ;
  sphere_r = sr != undef ? sr : sd != undef ? sd / 2 : handle_r * 2;

  rotate_extrude(convexity=10, $fs=0.2, $fa=2) {

    // Base with rounding
    square([base_r, base_h-base_rr]);
    translate([0, base_h-base_rr])square([base_r-base_rr, base_rr]);
    translate([base_r-base_rr, base_h-base_rr]) {
      intersection() {
        circle(r=base_rr, $fs=0.2);
        square([base_rr, base_rr]);
      }
    }

    // Handle
    square([handle_r, h-sphere_r]);

    // Rounding between base and handle
    translate([handle_r, base_h]) {
      difference() {
        square([base_rr, base_rr]);
        translate([base_rr, base_rr]) circle(r=base_rr, $fs=0.2);
      }
    }
  
    // Decorative sphere on top
   translate([0, h-sphere_r]) {
      intersection() {
        circle(r=sphere_r);
        translate([0, -sphere_r]) square([sphere_r, sphere_r*2]);
      }
    }
  
    // Rounding between handle and sphere if overhang is greater than 45
    if (sphere_r + handle_r > sqrt(2) * sphere_r) {
      x = sqrt(4*sphere_r*sphere_r-(sphere_r+handle_r)*(sphere_r+handle_r));
      translate([handle_r + sphere_r, h - sphere_r - x]) {
        difference() {
          translate([-sphere_r, 0]) square([sphere_r, x/2]);
          circle(r=sphere_r);
        }
      }
    } else {
      tr = (sphere_r - sqrt(2) * handle_r) / (sqrt(2) - 1);
      translate([handle_r+tr, h - sphere_r - (sphere_r + tr) / sqrt(2)]) {
        difference() {
          translate([-tr, 0]) square([tr-tr/sqrt(2), tr/sqrt(2)]);
          circle(r=tr);
        }
      }
    }
  }
}

coffee_tamper(h=50, bd=47, hd=10);
