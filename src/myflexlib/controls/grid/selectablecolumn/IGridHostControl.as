package myflexlib.controls.grid.selectablecolumn
{
  //Contract that must be implemented by the UIComponent hosting(i.e, acting as a parentDocument for)
  //the AdvancedDataGrid(ADG) control that intends to use the CheckboxHeaderRenderer implementation
  //as a customHeader for its ADG column.
  public interface IGridHostControl
  {
    
    //gets the value of the Binding variable for the checkBox state in the custom header of the ADG
    function get allSelected():Boolean;
    
    //sets the value of the Binding variable for the checkBox state in the custom header of the ADG
    function set allSelected(value:Boolean):void;
    
    //Adds/Removes all the items to/from the selection list
    function toggleSelectionList(selectedState:Boolean):void;
    
    //synchronize the header checkBox with its binding variable
    //This method is used to synchronize the checkBox in the header, when its binding variable is changed
    function updateHeaderSelection(selectedState:Boolean):void;
    
    //gets the Left padding to be associated with the checkbox control in the column header renderer
    function get leftPadding_CheckboxHeaderColumn():int;        
    
  }
}