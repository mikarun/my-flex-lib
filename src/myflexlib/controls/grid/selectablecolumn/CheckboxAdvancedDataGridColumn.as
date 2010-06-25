package myflexlib.controls.grid.selectablecolumn
{
  import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
  import mx.core.ClassFactory;
  
  public class CheckboxAdvancedDataGridColumn extends AdvancedDataGridColumn
  {
    //----------------------------------
    //  constants
    //----------------------------------
    
    //----------------------------------
    //  Constructors
    //----------------------------------
    
    public function CheckboxAdvancedDataGridColumn(columnName:String=null)
    {
      super(columnName);
      var cbHeaderRenderer:ClassFactory = new ClassFactory(CheckboxHeaderRenderer);      
      this.headerRenderer = cbHeaderRenderer;
      
      var cbRenderer:ClassFactory = new ClassFactory(CheckBoxAdvancedDataGridItemRenderer);      
      this.itemRenderer = cbRenderer;
      
    }
    
    
  }
}