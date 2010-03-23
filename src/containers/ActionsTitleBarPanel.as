package containers
{
  import mx.core.mx_internal;
  import mx.utils.BitFlagUtil;
  
  import spark.components.Group;
  import spark.components.Panel;
  import spark.layouts.supportClasses.LayoutBase;

  use namespace mx_internal;
  public class ActionsTitleBarPanel extends Panel
  {
    
    
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     */
    mx_internal static const ACTIONBAR_PROPERTY_FLAG:uint = 1 << 0;
    
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    
    /**
     *  Constructor. 
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function ActionsTitleBarPanel()
    {
      super();
    }
    
    
    //--------------------------------------------------------------------------
    //
    //  Variables 
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @private
     *  Several properties are proxied to actionBarGroup.  However, when actionBarGroup
     *  is not around, we need to store values set on SkinnableContainer.  This object 
     *  stores those values.  If actionBarGroup is around, the values are stored 
     *  on the actionBarGroup directly.  However, we need to know what values 
     *  have been set by the developer on the SkinnableContainer (versus set on 
     *  the actionBarGroup or defaults of the actionBarGroup) as those are values 
     *  we want to carry around if the actionBarGroup changes (via a new skin). 
     *  In order to store this info effeciently, actionBarGroupProperties becomes 
     *  a uint to store a series of BitFlags.  These bits represent whether a 
     *  property has been explicitely set on this SkinnableContainer.  When the 
     *  actionBarGroup is not around, actionBarGroupProperties is a typeless 
     *  object to store these proxied properties.  When actionBarGroup is around,
     *  actionBarGroupProperties stores booleans as to whether these properties 
     *  have been explicitely set or not.
     */
    mx_internal var actionBarGroupProperties:Object = { visible: true };
    
    //--------------------------------------------------------------------------
    //
    //  Skin parts 
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  actionBarGroup
    //---------------------------------- 
    
    [SkinPart(required="false")]
    
    /**
     *  The skin part that defines the appearance of the 
     *  action bar area of the container.
     *  By default, the ActionsTileBarPanelSkin class defines the action bar area to appear on the  
     *  left of the title of the Panel container with a grey background. 
     *
     *  @see skins.containers.ActionsTitleBarPanelSkin
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var actionBarGroup:Group;
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  actionBarContent
    //---------------------------------- 
    
    [ArrayElementType("mx.core.IVisualElement")]
    
    /**
     *  The set of components to include in the action bar area of the 
     *  Panel container. 
     *  The location and appearance of the action bar area of the Panel container 
     *  is determined by the spark.skins.spark.PanelSkin class. 
     *  By default, the PanelSkin class defines the action bar area to appear at the bottom 
     *  of the content area of the Panel container with a grey background. 
     *  Create a custom skin to change the default appearance of the action bar.
     *
     *  @default null
     *
     *  @see spark.skins.spark.PanelSkin
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function get actionBarContent():Array
    {
      if (actionBarGroup)
        return actionBarGroup.getMXMLContent();
      else
        return actionBarGroupProperties.actionBarContent;
    }
    
    /**
     *  @private
     */
    public function set actionBarContent(value:Array):void
    {
      if (actionBarGroup)
      {
        actionBarGroup.mxmlContent = value;
        actionBarGroupProperties = BitFlagUtil.update(actionBarGroupProperties as uint, 
          ACTIONBAR_PROPERTY_FLAG, value != null);
      }
      else
        actionBarGroupProperties.actionBarContent = value;
      
      invalidateSkinState();
    }
    
    //----------------------------------
    //  actionBarLayout
    //---------------------------------- 
    
    /**
     *  Defines the layout of the action bar area of the container.
     *
     *  @default HorizontalLayout
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function get actionBarLayout():LayoutBase
    {
      return (actionBarGroup) 
      ? actionBarGroup.layout 
        : actionBarGroupProperties.layout;
    }
    
    /**
     *  @private
     */
    public function set actionBarLayout(value:LayoutBase):void
    {
      if (actionBarGroup)
      {
        actionBarGroup.layout = value;
        actionBarGroupProperties = BitFlagUtil.update(actionBarGroupProperties as uint, 
          LAYOUT_PROPERTY_FLAG, true);
      }
      else
        actionBarGroupProperties.layout = value;
    }
    
    //----------------------------------
    //  actionBarVisible
    //---------------------------------- 
    
    /**
     *  If <code>true</code>, the action bar is visible.
     *  The flag has no affect if there is no value set for
     *  the <code>actionBarContent</code> property.
     *
     *  <p><b>Note:</b> The Panel container does not monitor the 
     *  <code>actionBarGroup</code> property. 
     *  If other code makes it invisible, the Panel container 
     *  might not update correctly.</p>
     *
     *  @default true
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function get actionBarVisible():Boolean
    {
      return (actionBarGroup) 
      ? actionBarGroup.visible 
        : actionBarGroupProperties.visible;
    }
    
    /**
     *  @private
     */
    public function set actionBarVisible(value:Boolean):void
    {
      if (actionBarGroup)
      {
        actionBarGroup.visible = value;
        actionBarGroupProperties = BitFlagUtil.update(actionBarGroupProperties as uint, 
          VISIBLE_PROPERTY_FLAG, value);
      }
      else
        actionBarGroupProperties.visible = value;
      
      invalidateSkinState();
      if (skin)
        skin.invalidateSize();
    }

    /**
     *  @private
     */
    override protected function partAdded(partName:String, instance:Object):void
    {
      super.partAdded(partName, instance);
      
      if (instance == actionBarGroup)
      {
        // copy proxied values from actionBarGroupProperties (if set) to contentGroup
        var newActionBarGroupProperties:uint = 0;
        
        if (actionBarGroupProperties.actionBarContent !== undefined)
        {
          actionBarGroup.mxmlContent = actionBarGroupProperties.actionBarContent;
          newActionBarGroupProperties = BitFlagUtil.update(newActionBarGroupProperties, 
            ACTIONBAR_PROPERTY_FLAG, true);
        }
        
        if (actionBarGroupProperties.layout !== undefined)
        {
          actionBarGroup.layout = actionBarGroupProperties.layout;
          newActionBarGroupProperties = BitFlagUtil.update(newActionBarGroupProperties, 
            LAYOUT_PROPERTY_FLAG, true);
        }
        
        if (actionBarGroupProperties.visible !== undefined)
        {
          actionBarGroup.visible = actionBarGroupProperties.visible;
          newActionBarGroupProperties = BitFlagUtil.update(newActionBarGroupProperties, 
            VISIBLE_PROPERTY_FLAG, true);
        }
        
        actionBarGroupProperties = newActionBarGroupProperties;
      }
    }
    
    /**
     *  @private
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    override protected function partRemoved(partName:String, instance:Object):void
    {
      super.partRemoved(partName, instance);
      
      if (instance == actionBarGroup)
      {
        // copy proxied values from contentGroup (if explicitely set) to contentGroupProperties
        
        var newActionBarGroupProperties:Object = {};
        
        if (BitFlagUtil.isSet(actionBarGroupProperties as uint, CONTROLBAR_PROPERTY_FLAG))
          newActionBarGroupProperties.actionBarContent = actionBarGroup.getMXMLContent();
        
        if (BitFlagUtil.isSet(actionBarGroupProperties as uint, LAYOUT_PROPERTY_FLAG))
          newActionBarGroupProperties.layout = actionBarGroup.layout;
        
        if (BitFlagUtil.isSet(actionBarGroupProperties as uint, VISIBLE_PROPERTY_FLAG))
          newActionBarGroupProperties.visible = actionBarGroup.visible;
        
        actionBarGroupProperties = newActionBarGroupProperties;
        
        actionBarGroup.mxmlContent = null;
        actionBarGroup.layout = null;
      }
    }
    
    /**
     *  @private
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    override protected function getCurrentSkinState():String
    {
      
      var state:String = super.getCurrentSkinState();
      if (actionBarGroup)
      {
        if (BitFlagUtil.isSet(actionBarGroupProperties as uint, ACTIONBAR_PROPERTY_FLAG) &&
          BitFlagUtil.isSet(actionBarGroupProperties as uint, VISIBLE_PROPERTY_FLAG))
          state += "WithActionBar";
      }
      else
      {
        if (actionBarGroupProperties.actionBarContent &&
          actionBarGroupProperties.visible)
          state += "WithActionBar";
      }
      
      return state;
    }
  }
}