package myflexlib.renderers.grid
{
  import flash.events.Event;
  
  import mx.controls.AdvancedDataGrid;
  import mx.controls.advancedDataGridClasses.MXAdvancedDataGridItemRenderer;
  import mx.events.AdvancedDataGridEvent;
  
  import myflexlib.controls.grid.ComboBoxHeaderADGColumn;
  
  import spark.components.ComboBox;
  import spark.components.HGroup;
  import spark.components.Label;
  
  public class ComboBoxADGHeaderRenderer extends MXAdvancedDataGridItemRenderer
  {
    //----------------------------------
    //  constants
    //----------------------------------
    
    //----------------------------------
    //  Constructors
    //----------------------------------
    
    public function ComboBoxADGHeaderRenderer()
    {
      super();            
    }
    
    //----------------------------------
    //  Properties
    //----------------------------------
    private var _data:ComboBoxHeaderADGColumn;
    
    private var _combo:ComboBox;
    
    override protected function createChildren():void{
      super.createChildren();
      
      var lbl:Label = new Label();
      lbl.text = label;
      //addElement(lbl);
      _combo = new ComboBox();      
      //addElement(_combo);
      
      var group:HGroup = new HGroup();
      group.addElement(lbl);
      group.addElement(_combo);
      addElement(group);
      _combo.addEventListener("change", changeHandler);
    }
    
    override public function get data():Object
    {
      return _data;
    }
    
   override public function set data(value:Object):void
    {
      _data = value as ComboBoxHeaderADGColumn;
      (listData.owner as AdvancedDataGrid).addEventListener(AdvancedDataGridEvent.HEADER_RELEASE, sortEventHandler);
      _combo.dataProvider = _data.comboBoxDataProvider;
      _combo.selectedIndex = _data.selectedIndex;
    }
    
    private function sortEventHandler(event:AdvancedDataGridEvent):void
    {
      if (event.itemRenderer == this)
        event.preventDefault();
    }
    
    private function changeHandler(event:Event):void
    {
      _data.selectedIndex = _combo.selectedIndex;
      _data.selectedItem = _combo.selectedItem;
      _data.dispatchEvent(event);
    }
    
    
  }
}
