package myflexlib.controls.grid.selectablecolumn
{
  import flash.display.DisplayObject;
  import flash.events.MouseEvent;
  
  import mx.controls.AdvancedDataGrid;
  import mx.controls.CheckBox;
  import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
  import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderRenderer;
  import mx.core.UITextField;
  
  import spark.components.HGroup;
  
  //Customizes the default AdvancedDataGridHeaderRenderer by displaying the checkbox in the header to
  //provide the SelectAll functionality in the grid. It uses the default sortItemRenderer of the grid, if not specified.
  public class CheckboxHeaderRenderer extends AdvancedDataGridHeaderRenderer
  {
    //stores the associated column
    private var _gridColumn:AdvancedDataGridColumn;
    //the checkBox control to be added as a child control
    private var checkBox:CheckBox;
    //stores the parentDocument(HostControl)
    private var _hostControl:IGridHostControl=null;
    //stores the default leftPadding for the checkbox control
    private const LEFT_PADDING:int = 5;
    
    //constructor
    public function CheckboxHeaderRenderer()
    {
      
      super();
      
      this.id = "checkboxHeaderRenderer";
      //initialize the checkbox control
      checkBox = new CheckBox();
      checkBox.label="";		 
      
      //BindingUtils.bindProperty(checkBox,"selected",HostControl,"allSelected");
      
      //subscribe to the events of interest...
      checkBox.addEventListener(MouseEvent.CLICK,OnCheckboxClick);
      addEventListener(MouseEvent.ROLL_OVER,OnMouseRollOver);
    }
    
    //gets the associated dataGrid column
    private function get gridColumn():AdvancedDataGridColumn{
      if(_gridColumn == null){
        _gridColumn = data as AdvancedDataGridColumn;
      }
      return _gridColumn;
    }
    
    ////////////////////// EVENT Handlers ////////////////////////////
    
    //Response to Mouse RollOver event
    private function OnMouseRollOver(event:MouseEvent):void{
      
      //control the sortable property of the column
      if(event.localX > checkBox.x + checkBox.measuredWidth){
        if(gridColumn != null){
          gridColumn.sortable = true;
        }
      }
      else{
        if(gridColumn != null){
          gridColumn.sortable = false;
        }
      }
    }
    
    //response to the click event on the checkbox
    private function OnCheckboxClick(event:MouseEvent):void{
      
      //(un)select the items
      if(HostControl != null){
        
        HostControl.toggleSelectionList(checkBox.selected);
      } 
      
      //refresh the UI
      if(listData != null){
        
        var grid:AdvancedDataGrid = listData.owner as AdvancedDataGrid;
        if(grid != null){
          grid.invalidateList();
        }
      }
    }
    
    ////////////////////// VIRTUAL Methods ////////////////////////////
    
    //gets the associated HostControl(ParentDocument)
    //The ParentDocument control hosting the AdvancedDataGrid must implement IGridHostControl
    //Returns Null, if the HostControl(ParentDocument) doesn't implement IGridHostControl
    public virtual function get HostControl():IGridHostControl{
      
      if(_hostControl == null){
        _hostControl = this.parentDocument as IGridHostControl;
      }
      return _hostControl;
    }	 
    
    //gets the left padding for the checkbox in the header
    public virtual function get LeftPadding():int{
      
      if(HostControl != null){
        
        return HostControl.leftPadding_CheckboxHeaderColumn;
      }
      
      return LEFT_PADDING;
    }
    
    ////////////////////// OVERRIDEN Methods ////////////////////////////
    
    //overriden to add the custom components
    override protected function createChildren():void{
      
      super.createChildren();      
      addChild(checkBox);
      
    }
    
    //performs the layout of the child controls
    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
      
      super.updateDisplayList(unscaledWidth,unscaledHeight);
      
      var textLabel:UITextField;
      var n:int = numChildren;
      for (var i:int = 0; i < n; i++)
      {
        var c:DisplayObject = getChildAt(i);
        
        if (c is CheckBox)
        {
          if( LeftPadding == -1)
            c.x = (unscaledWidth - c.width)/2;
          else
            c.x = LeftPadding;
            
          c.y = (unscaledHeight - c.height)/2;                    
          
        }else if(c is UITextField){
          
          textLabel = c as UITextField;
        }                
      }
      
      //check to avoid overllaping of text on the checkbox
      var xMin_text:int = checkBox.x + checkBox.measuredWidth;
      if(textLabel !=null && textLabel.x < xMin_text){
        
        textLabel.x = xMin_text;
        textLabel.truncateToFit();
        
      }
      
    }
    
    //override to bind the checkbox state
    override protected function commitProperties():void{
      
      //set the properties of the checkBox
      if(HostControl != null){
        checkBox.selected = HostControl.allSelected;
      }
      super.commitProperties();
    }
  }
}