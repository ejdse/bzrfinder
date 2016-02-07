PImage bg; String image = "../track.JPG";  // image size = 1049 x 862
ArrayList<Float> endX = new ArrayList(), endY = new ArrayList();
ArrayList<Float>  controlX1 = new ArrayList(), controlY1 = new ArrayList();
ArrayList<Float>  controlX2 = new ArrayList(), controlY2 = new ArrayList();
int one = -1, two = 1, deltaX = 15, deltaY = 5;
enum states { endpoints, controlpoint, done} ;
boolean noprint = false;
states state = states.endpoints;
void setup() { size(1049, 862); }
void draw() {
    // load background image
    bg = loadImage(image);
    image(bg, 0, 0, width, height);
    background(bg);
    for (int i = 0; i < endX.size(); i++)
    ellipse(endX.get(i),endY.get(i),15,15);
    if (state==states.controlpoint && controlX1.size()+1 < endX.size()){
  ellipse(mouseX+(one*deltaX),mouseY+(one*deltaY),15,15);
  ellipse(mouseX+(two*deltaX),mouseY+(two*deltaY),15,15);
      bezier(endX.get(controlX1.size()), endY.get(controlX1.size()),
      new Float(mouseX+(one*deltaX)),new Float(mouseY+(one*deltaY)),new Float(mouseX+(two*deltaX)),new Float(mouseY+(two*deltaY)),
      endX.get(controlX1.size()+1), endY.get(controlX1.size()+1));
    } else if (controlX1.size() == endX.size() && state==states.controlpoint) state = states.done;
    if (state == states.done && !noprint){
      noprint = true;
      for (int i = 0 ; i < endX.size()-1; i++)
      println ("{"+(int(endX.get(i)))+","+(int(endY.get(i)))+","+(int(controlX1.get(i)))+","+(int(controlY1.get(i)))+","+(int(controlX2.get(i)))+","+(int(controlY2.get(i)))+","+(int(endX.get(i+1)))+","+(int(endY.get(i+1)))+"}");
    }
}
void mouseWheel(MouseEvent event) {
    if (state==states.controlpoint){
  float e = event.getCount();
  println(event.getButton()+":"+e);
  if (event.getButton()<3) deltaX+=e;
  else deltaY+=e;
}
}
void mousePressed(MouseEvent event) {
  
  if (event.getButton() >30){
  switch(state){
    case endpoints:
  println(mouseX+","+mouseY);
  ellipse(mouseX,mouseY,15,15);
  endX.add(new Float(mouseX));
  endY.add(new Float(mouseY));
  break;
    case controlpoint:
  ellipse(mouseX+(one*deltaX),mouseY+(one*deltaY),15,15);
  ellipse(mouseX+(two*deltaX),mouseY+(two*deltaY),15,15);
  if (event.getButton() >38){
  controlX1.add(new Float(mouseX+(one*deltaX)));
  controlY1.add(new Float(mouseY+(one*deltaY)));
  controlX2.add(new Float(mouseX+(two*deltaX)));
  controlY2.add(new Float(mouseY+(two*deltaY)));
  }
  break;
    case done:
  break;
    default: break;
  }
  if (endX.get(0)<=(new Float(mouseX+15.0)) && endX.get(0)>=(new Float(mouseX-15.0)) && endY.get(0) >=(new Float(mouseY-15.0)) && endY.get(0) <=(new Float(mouseY+15.0)) && endY.size()>1){
    state=states.controlpoint;
  }
  }
}

void mouseMoved(){
  switch(state){
    case endpoints:
    ellipse(mouseX,mouseY,15,15);
    break;
    case controlpoint:
    fill(255,0,0);
  ellipse(mouseX+(one*deltaX),mouseY+(one*deltaY),15,15);
    fill(0,0,255);
  ellipse(mouseX+(two*deltaX),mouseY+(two*deltaY),15,15);
    fill(255,255,255);
    break;
    default:
    break;
  }
}