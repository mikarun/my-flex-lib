package myflexlib.controls.grid.selectablecolumn
{
  import flash.events.Event;
  
  public class ItemCheckEvent extends Event
  {
    //----------------------------------
    //  constants
    //----------------------------------
    
    public static const ITEM_CHECK_EVENT:String="ItemCheckEvent";
    
    //----------------------------------
    //  Constructors
    //----------------------------------
    
    public function ItemCheckEvent(bubbles:Boolean=false, cancelable:Boolean=false)
    {
      super(ITEM_CHECK_EVENT, bubbles, cancelable);
    }
    
    //----------------------------------
    //  Properties
    //----------------------------------
    
    private var _selected:Boolean;

    public function get selected():Boolean
    {
      return _selected;
    }

    public function set selected(value:Boolean):void
    {
      _selected = value;
    }

    private var _item:*;

    public function get item():*
    {
      return _item;
    }

    public function set item(value:*):void
    {
      _item = value;
    }
    
    
    
  }
}