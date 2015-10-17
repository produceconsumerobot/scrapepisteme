import processing.opengl.*;
import controlP5.*;

class ControlPanel {
  int cpHeight;
  int cpWidth;
  int x;
  int y;
  ControlP5 cp5;
  Group g1; 
  int margin;
  
  public ControlPanel(int w, int h, int _x, int _y) {
    cpHeight = h;
    cpWidth = w;
    x = _x;
    y = _y;
    margin = 10;
  }
  
  public void setup(PApplet pa) {
    int elemH;
    int elemY = margin;
    
    // ControlP5 Setup
    cp5 = new ControlP5(pa);
    
    //** ControlP5 Groups **//
    g1= cp5.addGroup("g1")
      .setPosition(x, y)
      .setSize(cpWidth, cpHeight)
      .setBackgroundColor(color(255,50))
      ;
      
    //** ControlP5 Elements **//
    // Search Button
    elemH = 20;
    cp5.addButton("Search")
     .setValue(0)
     .setPosition(margin, elemY)
     .setSize(cpWidth-margin*2, elemH)
     .setLabel("Search")
     .setColorBackground(color(0,160,0))
     .setColorForeground(color(0,120,0))
     .setColorActive(color(10,10,160))
     ;
    elemY += elemH + margin;
    
    // Search Tags
    elemH = 20;
    cp5.addTextfield("SearchTags")
     .setPosition(margin, elemY)
     .setSize(cpWidth-margin*2, elemH)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setLabel("Search Tag(s)")
     .setGroup(g1)
     ;
    elemY += elemH + margin*3;
    
    // Number of Pics
    elemH = 20;
    cp5.addSlider("cp5nPics")
     .setPosition(margin, elemY)
     .setSize(cpWidth-margin*2-margin*3, elemH)
     .setRange(1, 150)
     .setNumberOfTickMarks(150) 
     .setGroup(g1)
     .setLabel("N-Pics")
     .setDecimalPrecision(0)
     .setValue(30)
     ;
    elemY += elemH + margin*2;
    
    /*
    // Sort By
    elemH = 20;
    String[] sortOptions = {"Most Interesting", "Most Relevant", "Most Recent"};
    cp5.addDropdownList("SortBy")
     .setPosition(margin, elemY)
     .setSize(cpWidth-margin*2, elemH*sortOptions.length)
     .setGroup(g1)
     .addItems(java.util.Arrays.asList(sortOptions))
     .setValue(0)
     .setLabel(sortOptions[0])
     .setOpen(false)
     ;
    elemY += elemH + margin;
    
    // Blend Mode
    elemH = 20;
    String[] blendOptions = {
      "Average",
      "Blend",
      "Add",
      "Subtract",
      "Darkest",
      "Lightest",
      "Difference",
      "Exclusion",
      "Multiply",
      "Screen",
      "Replace",
      "Overlay",
      "Hard Light",
      "Soft Light",
      "Dodge",
      "Burn"
    };
    cp5.addDropdownList("BlendMode")
     .setPosition(margin, elemY)
     .setSize(cpWidth-margin*2, elemH*blendOptions.length)
     .setGroup(g1)
     .addItems(java.util.Arrays.asList(blendOptions))
     .setValue(0)
     .setLabel(blendOptions[0])
     .setOpen(false)
     ;
    elemY += elemH + margin;
    */
    
    // Auto-Levels
    elemH = 20;
    cp5.addCheckBox("AutoLevels")
      .setPosition(margin, elemY)
      .setSize(elemH, elemH)
      .setItemsPerRow(1)
      .addItem("Auto-Levels", 0)
    ;
    elemY += elemH + margin;

    
  }
  
  public void draw() {
    /*
    // Bring dropdown lists to front when open
    java.util.List allDropDownLists = cp5.getAll(DropdownList.class);
    for (int i=0; i<allDropDownLists.size(); i++) {
      if (((DropdownList) allDropDownLists.get(i)).isOpen()) {
        //((DropdownList) allDropDownLists.get(i)).bringToFront();
        println(allDropDownLists.get(i));
      }
    }
    */
  }
}

class ThumbPanel {
  int tpWidth;
  int tpHeight;
  int x;
  int y;
  public ThumbPanel(int w, int h, int _x, int _y) {
  }
  public void setup() {
  }
  public void draw() {
  }
}

//**** Global Variables ****//
ControlPanel cp;
//**** END Global Variables ****//

void setup(){
  size(1000,800,P3D);
  cp = new ControlPanel(200, height, 0, 0);
  cp.setup(this);

   println(cp.cp5.getAll());
    //println(cp.getController(cp5SortBy).getArrayValue());
    //println(cp.getController(cp5SortBy).getValueLabel());
    //println(cp.getController(cp5SortBy).getStringValue());
    //println(cp.getController(cp5SortBy).getCaptionLabel());
    
    //cp.cp5.getController("SortBy").setValue(2);
    //cp.cp5.getController("SortBy").setValueLabel("Most Recent");
    //cp.cp5.getController("SortBy").setCaptionLabel("Most Recent");
    //cp.cp5.getController("SortBy").setLabel("Most Recent");
    //cp.cp5.getController("SortBy").setStringValue("Most Recent");
}

void draw(){ 
  background(0);
  cp.draw();
}

//**** Event Controller ****//
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isGroup()) {
    println("got an event from group "
            +theEvent.getGroup().getName()
            +", isOpen? "+theEvent.getGroup().isOpen()
            );
            
  } else if (theEvent.isController()){
    theEvent.getController().bringToFront();
    println("got something from a controller "
            +theEvent.getController().getName()
            );
    //println(theEvent.getController().getValue());
    //println(theEvent.getController().getArrayValue());
    //println(theEvent.getController().getValueLabel());
    //println(theEvent.getController().getStringValue());
    //println(theEvent.getController().getCaptionLabel());
  }
}