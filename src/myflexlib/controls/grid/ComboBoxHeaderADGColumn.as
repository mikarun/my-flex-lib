package myflexlib.controls.grid
{
  import mx.collections.IList;
  import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
  
  /**
   *  Dispatched when the ComboBox contents changes as a result of user
   *  interaction, when the <code>selectedIndex</code> or
   *  <code>selectedItem</code> property changes, and, if the ComboBox control
   *  is editable, each time a keystroke is entered in the box.
   *
   *  @eventType mx.events.ListEvent.CHANGE
   */
  [Event(name="change", type="mx.events.ListEvent")]
  public class ComboBoxHeaderADGColumn extends AdvancedDataGridColumn
  {
    //----------------------------------
    //  constants
    //----------------------------------
    
    //----------------------------------
    //  Constructors
    //----------------------------------
    
    public function ComboBoxHeaderADGColumn(columnName:String=null)
    {
      super(columnName);
    }
    
    //----------------------------------
    //  Properties
    //----------------------------------
    /**
     *  The data provider for the combobox
     */
    public var comboBoxDataProvider:IList;
    
    /**
     *  The current combobox selectedIndex
     */
    public var selectedIndex:int = 0;
    
    /**
     *  The current combobox selectedItem
     */
    public var selectedItem:Object;
    
  }
}