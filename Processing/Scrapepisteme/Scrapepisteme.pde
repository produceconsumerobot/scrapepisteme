//import processing.opengl.*;
import controlP5.*;

//******** Photo ********//
class Photo{
  PImage img;
  float x;
  float y;
  float z;
  float smallWidth;
  float smallHeight;
  float currentWidth;
  float currentHeight;
  int id;
  boolean loading;
  public Photo(String url,float nx,float ny,int _id){
    img = requestImage(url);
    id = _id;
    loading = true;
    x = nx;
    y = ny;
    z = 0;
  }
  public void doneLoading(){
    loading = false;
    if(img.width > img.height){
      currentWidth = smallWidth = 120;
      currentHeight = smallHeight = img.height*(120/(float)img.width);
    }
    else{
      currentWidth = smallWidth = img.width*(120/(float)img.height);
      currentHeight = smallHeight = 120;
    }
  }
  public void drawImage(PGraphics g){
    g.translate(0,0,z);
    g.beginShape();
    g.texture(img);
    g.vertex(x*120 + (120-currentWidth)/2, y*120+(120-currentHeight)/2, 0, 0);
    g.vertex(x*120+currentWidth+(120-currentWidth)/2, y*120+(120-currentHeight)/2, 1, 0);
    g.vertex(x*120+currentWidth+(120-currentWidth)/2, y*120+currentHeight+(120-currentHeight)/2, 1, 1);
    g.vertex(x*120+(120-currentWidth)/2, y*120+currentHeight+(120-currentHeight)/2, 0, 1);
    g.endShape();
    g.translate(0,0,-z);
  }
  public void drawBuffer(PGraphics b){
    b.translate(0,0,z);
    b.beginShape();
    b.noStroke();
    b.fill(-(id + 2));
    b.vertex(x*120 + (120-currentWidth)/2, y*120+(120-currentHeight)/2);
    b.vertex(x*120+currentWidth+(120-currentWidth)/2, y*120+(120-currentHeight)/2);
    b.vertex(x*120+currentWidth+(120-currentWidth)/2, y*120+currentHeight+(120-currentHeight)/2);
    b.vertex(x*120+(120-currentWidth)/2, y*120+currentHeight+(120-currentHeight)/2);
    b.endShape(CLOSE);
    b.translate(0,0,-z);
  }
}
//******** END Photo ********//

//******** ControlPanel ********//
class ControlPanel {
  int w;
  int h;
  int x;
  int y;
  ControlP5 cp5;
  Group gr1; 
  int margin;
  
  public ControlPanel(int _w, int _h, int _x, int _y) {
    w = _w;
    h = _h;
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
    gr1= cp5.addGroup("gr1")
      .setPosition(x, y)
      .setSize(w, h)
      .setBackgroundColor(color(255,50))
      ;
      
    //** ControlP5 Elements **//
    // Search Button
    elemH = 20;
    cp5.addButton("Search")
     .setValue(0)
     .setPosition(margin, elemY)
     .setSize(w-margin*2, elemH)
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
     .setSize(w-margin*2, elemH)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setLabel("Search Tag(s)")
     .setGroup(gr1)
     ;
    elemY += elemH + margin*3;
    
    // Number of Pics
    elemH = 20;
    cp5.addTextfield("nPics")
     .setPosition(margin, elemY)
     .setSize(w-margin*2, elemH)
     .setFont(createFont("arial",15))
     .setAutoClear(false)
     .setValue("5")
     .setLabel("N-Pics")
     .setGroup(gr1)
     ;
    elemY += elemH + margin*3;
     
    /*
    elemH = 20;
    cp5.addSlider("cp5nPics")
     .setPosition(margin, elemY)
     .setSize(w-margin*2-margin*3, elemH)
     //.setRange(1, 150)
     //.setNumberOfTickMarks(150) 
     .setGroup(gr1)
     //.setLabel("N-Pics")
     //.setDecimalPrecision(0)
     //.setValue(30)
     ;
    elemY += elemH + margin*2;
    */
    
    
    // Sort By
    elemH = 20;
    String[] sortOptions = {
      "interestingness-desc", 
      "interestingness-ASc", 
      "date-posted-desc",
      "date-posted-asc",
      "date-taken-asc",
      "date-taken-desc",
      "relevance"};
    cp5.addDropdownList("SortBy")
     .setPosition(margin, elemY)
     .setSize(w-margin*2, elemH*sortOptions.length)
     .setGroup(gr1)
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
     .setSize(w-margin*2, elemH*blendOptions.length)
     .setGroup(gr1)
     .addItems(java.util.Arrays.asList(blendOptions))
     .setValue(0)
     .setLabel(blendOptions[0])
     .setOpen(false)
     ;
    elemY += elemH + margin;
    
    
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
    
    // Bring dropdown lists to front when open
    java.util.List allDropDownLists = cp5.getAll(DropdownList.class);
    for (int i=0; i<allDropDownLists.size(); i++) {
      if (((DropdownList) allDropDownLists.get(i)).isOpen()) {
        ((DropdownList) allDropDownLists.get(i)).bringToFront();
        println(allDropDownLists.get(i));
      }
    }
    
  }
}
//******** END ControlPanel ********//

class ThumbPanel {
  int w;
  int h;
  int x;
  int y;
  int nRows;
  int nCols;
  int nPics;
  int maxThumbWidth;
  int maxThumbHeight;
  
  public ThumbPanel(int _x, int _y) {
    x = _x;
    y = _y;
  }
  public void setup(int _w, int _nPics, int _maxThumbWidth, int _maxThumbHeight ) {
    w = _w;
    nPics = _nPics;
    maxThumbWidth = _maxThumbWidth;
    maxThumbHeight = _maxThumbHeight;
    nCols = w / maxThumbWidth;
    nRows = 1 + (nPics / nCols);  
    h = nRows * maxThumbHeight;
  }
  public void draw(PImage img, int i) {
    int col = i % nCols;
    int row = i / nCols;
    tint(255);
    image(img, x + maxThumbWidth*(col+0.5), y + maxThumbHeight*(row+0.5), maxThumbWidth, maxThumbHeight);
  }
}

//**** Global Variables ****//
ControlPanel cp;
ThumbPanel tp;
PImage mashupImage;
ArrayList photos;
//PGraphics buffert;
//**** END Global Variables ****//

void setup(){
  int controlPanelWidth = 200;
  
  size(1000,800,P3D);
  
  // Setup ControlPanel
  cp = new ControlPanel(controlPanelWidth, height, 0, 0);
  cp.setup(this);
  
  // Setup the ThumbPanel
  int nPics = int(((Textfield) cp.cp5.getController("nPics")).getText());
  tp = new ThumbPanel(controlPanelWidth, 0);
  tp.setup(width - controlPanelWidth, nPics, 50, 50); 
  
  
  photos = new ArrayList();
  loadImagesFromApiCall("https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=ce44a738b6af08a5969aeadeeefdc7f4&per_page="+nPics);
  imageMode(CENTER);

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
  int nLoadedPics = 0; // Counts number of pics that have been downloaded
  
  background(0);
  cp.draw();
  
  //**** Draw Thumbnails ****//
  for(int i = 0; i< photos.size();i++){
    Photo p = (Photo)photos.get(i);
    if(p.loading && p.img.width >0){
      // Image is loaded
      p.doneLoading();
    }
    if (!p.loading) {
      // Image is loaded, draw the thumbnail
      tp.draw(p.img, i);
      nLoadedPics++;
    } 
  } 
    //**** END Draw Thumbnails ****//
}

//******** loadImagesFromApiCall ********//
void loadImagesFromApiCall(String callURL){
  //mashupLoaded = false;
  int goodPhotos = 0;
  photos.clear();
  println(callURL);
  XML xml = loadXML(callURL);
  println("xmlChildCount=" + xml.getChildCount());
  XML photoList = xml.getChild(1);
  int childCount = photoList.getChildCount();
  println("childCount=" + childCount);
  //println(xml.getChild(1));
  int perRow = childCount/5;
  int yPos = 0;
  for(int i = 0; i < childCount;i++){
    String farm = photoList.getChild(i).getString("farm");
    String server = photoList.getChild(i).getString("server");
    String id = photoList.getChild(i).getString("id");
    String secret = photoList.getChild(i).getString("secret");
    if(i%perRow == 0){
      yPos++;
    }
    if (farm != null && server != null && id != null && secret != null) {
      //photos.add(new Photo("http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+".jpg",i%perRow,yPos,i+1));
      photos.add(new Photo("http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+".jpg",i%perRow,yPos,i+1));
      goodPhotos++;
    } 
  }
  println("goodPhotos=" + goodPhotos);
}
//******** END loadImagesFromApiCall ********//

//******** Event Controller ********//
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
    String controllerName = theEvent.getController().getName();
    if (controllerName == "Search") {
      search();
    }
    
    //println(theEvent.getController().getValue());
    //println(theEvent.getController().getArrayValue());
    //println(theEvent.getController().getValueLabel());
    //println(theEvent.getController().getStringValue());
    //println(theEvent.getController().getCaptionLabel());
  }
}
//******** END Event Controller ********//

//******** Search ********//
void search() {
  String tags = ((Textfield) cp.cp5.getController("SearchTags")).getText();
  tags = tags.trim().replace(' ', '+');
  int nPics = int(((Textfield) cp.cp5.getController("nPics")).getText());
  String sortBy = ((DropdownList) cp.cp5.getController("SortBy")).getStringValue();
  if(tags.length()>0 && nPics > 0){
    loadImagesFromApiCall("https://api.flickr.com/services/rest/?method=flickr.photos.search"
          +"&api_key=ce44a738b6af08a5969aeadeeefdc7f4"
          +"&tags="+tags
          +"&per_page="+nPics
          +"&sort="+sortBy
          +"&media=photos"
          //+"license=0"
          );
  }
  
}
//******** END Search ********//