import 'dart:ui';
import 'dart:math';

const double ANGLE_0 = 0;
const double ANGLE_90 = pi/2;
const double ANGLE_180 = pi;

/*
  Indicate if a moving point will bounce off this object
  - x and y coordinates of point
  - the speed and direction of movement of the point as xSpeed and ySpeed
  - the amount of movement is a time value
  If the point will bounce off the object, return the new dx and dy that
  the point will now move after the bounce
  If the point will not bounce off the object, return null

 */
abstract class Bounceable {
  Offset bounce(double x, double y, double xSpeed, double ySpeed, double t, );
}

/*
  Bounce a point off a rectangle
  If the ball will not bounce, return null
  If it will bounce, return the new point movement dx and dy
 */
Offset bounceRectangle(double x, double y, double xSpeed, double ySpeed, double t, Rect rect, ) {
  // if the point will not move into the rectangle, we do not bounce
  x += t*xSpeed;  // move point to see if it will be inside the rectangle
  y += t*ySpeed;
  if (!rect.contains(Offset(x,y))) return null; // not inside rectangle

  // see if we are closes to an x side of the rectangle (left, right) or a y side (top, buttom)
  double closestX = min(x - rect.left, rect.right - x);
  double closestY = min(y - rect.top, rect.bottom - y);
  if (closestX < closestY) {
    // we are closest to the left/right of the block, so we hit a vertical edge
    xSpeed = -xSpeed;  // reverse x direction
  } else {
    // we are closest to the top/bottom of the block, so we hit a horizontal edge
    ySpeed = -ySpeed;  // reverse y direction
  }
  return Offset(xSpeed,ySpeed);
}

/*
  Bounce a point off an aiming rectangle
  The direction of the bounce depends on where on the side of the rectangle it hits
  If the ball will not bounce, return null
  If it will bounce, return the new point movement dx and dy
 */
Offset bounceAimingRectangle(double x, double y, double xSpeed, double ySpeed, double t, Rect rect, ) {
  // if the point will not move into the rectangle, we do not bounce
  x += t*xSpeed;  // move point to see if it will be inside the rectangle
  y += t*ySpeed;
  if (!rect.contains(Offset(x,y))) return null; // not inside rectangle

  // see if we are closes to an x side of the block (left, right) or a y side (top, buttom)
  double closestX = min(x - rect.left, rect.right - x);
  double closestY = min(y - rect.top, rect.bottom - y);
  double totalSpeed = xSpeed.abs() + ySpeed.abs();  // we divide up the speed by how the block is hit

  if (closestX < closestY) {
    // we are closest to the left/right of the rectangle, so we hit a vertical edge
    if (x - rect.topLeft.dx < rect.topRight.dx - x) {
      // we hit the left side
      // make an aim number where the ball hit the left side
      // -1 means top left, 0 is middle left, 1 is bottom left.
      // This number determines how much of the speed goes in the y direction.
      double middle = (rect.top + rect.bottom) / 2;
      double aim = (y - middle)/rect.height*2;
      ySpeed = totalSpeed * aim;  // ball can go up or down depending on aim
      xSpeed = -(totalSpeed - ySpeed.abs()); // ball goes to the left
    } else {
      // we hit the right side
      // make an aim number where the ball hit the right side
      // -1 means top right, 0 is middle right, 1 is bottom right.
      // This number determines how much of the speed goes in the y direction.
      double middle = (rect.top + rect.bottom) / 2;
      double aim = (y - middle)/rect.height*2;
      ySpeed = totalSpeed * aim;  // ball can go up or down depending on aim
      xSpeed = totalSpeed - ySpeed.abs(); // ball goes to the right
    }
  } else {
    // we are closest to the top/bottom of the rectangle, so we hit a horizontal edge
    if (y - rect.topLeft.dy < rect.bottomLeft.dy - y) {
      // we hit the top
      // make an aim number where the ball hit the top side
      // -1 means top left, 0 is top middle, 1 is top right.
      // This number determines how much of the speed goes in the x direction.
      double middle = (rect.left + rect.right) / 2;
      double aim = (x - middle)/rect.width*2;
      xSpeed = totalSpeed * aim;  // ball can go left or right depending on aim
      ySpeed = -(totalSpeed - xSpeed.abs()); // ball goes up
    } else {
      // we hit the bottom
      // make an aim number where the ball hit the bottom side
      // -1 means bottom left, 0 is bottom middle, 1 is bottom right.
      // This number determines how much of the speed goes in the x direction.
      double middle = (rect.left + rect.right) / 2;
      double aim = (x - middle)/rect.width*2;
      xSpeed = totalSpeed * aim;  // ball can go left or right depending on aim
      ySpeed = totalSpeed - xSpeed.abs(); // ball goes down
    }
  }

  return Offset(xSpeed,ySpeed);
}

/*
    Return the angle of a line
    Angle will be between 0 and 180 degrees, converted to radians
    The angle uses the computer's coordinate system where 0 is horizontal
    increases as you go counter-clockwise
    12:00  :  90
     1:300 :  45
     3:00  :   0
     4:30  : 135
     6:00  :  90
     7:30  :  45
     9:00  :   0
    10:30  : 135

  var angle12 = angleOfLine(0,0,0,-1); // 12:00 is 90 deg
  var angle130 = angleOfLine(0,0,1,-1); // 1:30 is 45 deg
  var angle3 = angleOfLine(0,0,1,0); // 3:00 is 0 deg
  var angle430 = angleOfLine(0,0,1,1); // 4:30 is 135 deg
  var angle6 = angleOfLine(0,0,0,1); // 6:00 is 90 deg
  var angle730 = angleOfLine(0,0,-1,1); // 7:30 is 45 deg
  var angle9 = angleOfLine(0,0,-1,0); // 9:00 is 0 deg
  var angle1030 = angleOfLine(0,0,-1,-1); // 10:30 is 135 deg
  print ("$angle12 $angle130 $angle3 $angle430 $angle6 $angle730 $angle9 $angle1030");

  will print 90 45 0 135 90 45 0 135

 */
double angleOfLine(double x1, double y1, double x2, double y2,) {
  double dy = y2 - y1;
  double dx = x2 - x1;
  double theta = atan(dy/dx); // range (-PI, PI]
  theta = pi-theta;  // to computer coordinates
  if (theta < 0) theta += pi;
  if (theta >= pi) theta -= pi;
  //theta *= 180/pi; // to degrees
  return theta;
}


// Given three colinear points p, q, r, the function checks if
// point q lies on line segment 'pr'
bool _onSegment(double px, double py, double qx, double qy, double rx, double ry) {
return qx <= max(px, rx) && qx >= min(px, rx) &&
       qy <= max(py, ry) && qy >= min(py, ry);
}

const _TINY = 0.001;
bool _isZero(double n) => _TINY > n && n > -_TINY;
bool _isEqual(double x, double y) => _isZero(x-y);

// To find orientation of ordered triplet (p, q, r).
// The function returns following values
// 0 --> p, q and r are colinear
// 1 --> Clockwise
// 2 --> Counterclockwise
int _orientation(double px, double py, double qx, double qy, double rx, double ry) {
  // See https://www.geeksforgeeks.org/orientation-3-ordered-points/
  // for details of below formula.
  double val = (qy - py) * (rx - qx) - (qx - px) * (ry - qy);
  if (_isZero(val)) return 0;  // colinear
return (val > 0)? 1: 2; // clock or counterclock wise
}

// returns true if line segment 'p1q1' and 'p2q2' intersect.
bool linesIntersect(double p1x, double p1y, double q1x, double q1y,
                  double p2x, double p2y, double q2x, double q2y) {
  // Find the four orientations needed for general and
  // special cases
  int o1 = _orientation(p1x, p1y, q1x, q1y, p2x, p2y);
  int o2 = _orientation(p1x, p1y, q1x, q1y, q2x, q2y);
  int o3 = _orientation(p2x, p2y, q2x, q2y, p1x, p1y);
  int o4 = _orientation(p2x, p2y, q2x, q2y, q1x, q1y);

  // General case
  if (o1 != o2 && o3 != o4) return true;

  // Special Cases
  // p1, q1 and p2 are colinear and p2 lies on segment p1q1
  if (o1 == 0 && _onSegment(p1x, p1y, p2x, p2y, q1x, q1y)) return true;

  // p1, q1 and q2 are colinear and q2 lies on segment p1q1
  if (o2 == 0 && _onSegment(p1x, p1y, q2x, q2y, q1x, q1y)) return true;

  // p2, q2 and p1 are colinear and p1 lies on segment p2q2
  if (o3 == 0 && _onSegment(p2x, p2y, p1x, p1y, q2x, q2y)) return true;

  // p2, q2 and q1 are colinear and q1 lies on segment p2q2
  if (o4 == 0 && _onSegment(p2x, p2y, q1x, q1y, q2x, q1y)) return true;

  return false; // Doesn't fall in any of the above cases
}

/*
  Bounce a point off a line of any angle
  - point is x,y
  - speed is xSpeed, ySpeed,
  - movement defined by time is t
  - the bounce line points are x1,y1 and x2,y2
  If the ball will not bounce, return null
  If it will bounce, return the new point movement dx and dy

  Notes about bouncing off a line
  some of the original x speed of the ball is transferred to the new x speed
  any of the original x speed not transferred to the new x gets transferred to the new y
  same with the y speeds

  When a line is at 0 degrees (horizontal)
  - all of the original x speed is transferred to the new x speed
    this is because a horizontal line does not affect the x direction of the ball
  - all of the original y speed is transferred to the new y speed in revers
    this is because the ball changes vertical direction when it bounces off a horizontal line

  When a line is at 90 degrees (vertical)
  - all of the original x speed is transferred to the new x speed in revers
    this is because the ball changes horizontal direction when it bounces off a horizontal line
  - all of the original y speed is transferred to the new y speed
    this is because a vertical line does not affect the y direction of the ball

  between 0 and 90 degrees
  - x speed goes from it's initial speed to reverse it's initial speed
  - any speed that x does not transfer to the new x goes to the new y in the reverse direction
    think of a ball moving from left to right hiting a slanted line
    the ball will move up because some of the x speed is transferred in the negative y direction
  - y speed goes from it's initial speed in reverse to its initial speed
  - any speed that y does not transfer to the new y goes to the new x in the reverse direction

  At 180 degrees, it is the same as 0 degrees

  between 90 and 180 degrees
  - x speed goes from reverse it's initial speed to it's initial speed
  - any speed that x does not transfer to the new x goes to the new y
  - y speed goes from it's initial speed to its initial speed in reverse
  - any speed that y does not transfer to the new y goes to the new x


 */
Offset bounceLine(double x, double y, double xSpeed, double ySpeed, double t,
                  double x1, double y1, double x2, double y2, ) {

  // get the point where the original point will move
  double dx = t*xSpeed;
  double dy = t*ySpeed;

  // if the movement of the point does not intersect the line, there will be no bounce
  if (!linesIntersect(x,y,x+dx,y+dy,x1,y1,x2,y2)) return null;

  double angle = angleOfLine(x1, y1, x2, y2);
  // new speed starts at 0
  double xNew = 0.0;
  double yNew = 0.0;
  if (angle >= ANGLE_0 && angle <= ANGLE_90) {
    // get range from -1 to 1 where the angle falls
    double range = angle / ANGLE_90;  // between 0 and 1
    range = range*2 - 1;  // between -1 and 1
    print("range 0-90: $range");

    // transfer the x and y speeds to the new speed
    double xferX = -(xSpeed * range);
    xNew += xferX;
    double xferY = -(xSpeed.abs() - xferX);  // left over x
    yNew += xSpeed > 0 ? xferY : -xferY;
    xferY = ySpeed * range;
    yNew += xferY;
    xferX = -(ySpeed.abs() - xferY);
    xNew += ySpeed > 0 ? xferX : -xferX;
  } else { // between 90 and 180
    double range = (angle - ANGLE_90) / ANGLE_90;  // between 0 and 1
    range = range*2 - 1;  // between -1 and 1
    print("range 90-180: $range");

    // transfer the x and y speeds to the new speed
    double xferX = xSpeed * range;
    xNew += xferX;
    double xferY = xSpeed.abs() - xferX.abs();  // left over x
    yNew += xSpeed > 0 ? xferY : -xferY;
    xferY = -(ySpeed * range);
    yNew += xferY;
    xferX = ySpeed.abs() - xferY.abs();
    xNew += ySpeed > 0 ? xferX : -xferX;
  }

  return Offset(xNew,yNew);
}

/*
  Bounce a point off a polygon made up of points
  For efficiency, test if the point will move inside the polygon before calling this method
  If the ball will not bounce, return null
  If it will bounce, return the new point movement dx and dy
 */
Offset bouncePolygon(double x, double y, double xSpeed, double ySpeed, double t,
                     List<Offset> polygon, ) {

  // loop through all of the lines of the polygon and if one bounces, return that one
  for (int i=0; i<polygon.length; i++) {
    // get the 2 points of the line
    double x1=polygon[i].dx;
    double y1=polygon[i].dy;
    double x2=(i+1 < polygon.length) ? polygon[i].dx : polygon[0].dx;
    double y2=(i+1 < polygon.length) ? polygon[i].dy : polygon[0].dy;

    // try to bounce off this line
    var offset = bounceLine(x,y,xSpeed,ySpeed,t,x1,y1,x2,y2,);
    if (offset != null) return offset;
  }

  return null; // no lines bounced
}

