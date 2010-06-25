package myflexlib.controls.grid.selectablecolumn
{
  import flash.events.MouseEvent;
  import flash.geom.Point;
  
  import mx.controls.AdvancedDataGrid;
  import mx.controls.listClasses.IListItemRenderer;
  
  public class PreventSelectionOnColumnClickGrid extends AdvancedDataGrid
  {
    //----------------------------------
    //  constants
    //----------------------------------
    
    //----------------------------------
    //  Constructors
    //----------------------------------
    
    public function PreventSelectionOnColumnClickGrid()
    {
      super();
    }
    
    
    private var _columnIndex:int;
    
    
    //----------------------------------
    //  Properties
    //----------------------------------
    
    override protected function mouseUpHandler(event:MouseEvent):void{
      var item:IListItemRenderer = mouseEventToItemRenderer(event);
      var pt:Point = itemRendererToIndices(item);
      
      selectable = pt.x != 0;
      super.mouseUpHandler(event);
    }
    
    override protected function mouseDownHandler(event:MouseEvent):void{
      var item:IListItemRenderer = mouseEventToItemRenderer(event);
      var pt:Point = itemRendererToIndices(item);
      
      selectable = pt.x != 0;
      super.mouseDownHandler(event);
    }
        
  }
}