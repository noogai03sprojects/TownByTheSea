import tjson.TJSON;

class JSONExt
{
    public static function encode(o : Dynamic, ?style:Dynamic = null) 
    {
        return TJSON.encode(o, style);
    }

    public static function decode<T>(s : String, typeClass : Class<Dynamic>) : T 
    {
        var o = TJSON.parse(s);
        var inst = Type.createEmptyInstance(typeClass);
        JSONExt.populate(inst, o);
        return inst;
    }

    private static function populate(inst, data) 
    {
        for (field in Reflect.fields(data)) 
        {
            if (field == "_explicitType")
                continue;

            var value = Reflect.field(data, field);
            var valueType = Type.getClass(value);
            var valueTypeString:String = Type.getClassName(valueType);
            var isValueObject:Bool = Reflect.isObject(value) && valueTypeString != "String";
            var valueExplicitType:String = null;

            if (isValueObject)
            {
                valueExplicitType = Reflect.field(value, "_explicitType");
                if (valueExplicitType == null && valueTypeString == "Array")
                    valueExplicitType = "Array";
            }

            if (valueExplicitType != null)
            {
                var fieldInst = Type.createEmptyInstance(Type.resolveClass(valueExplicitType));
                populate(fieldInst, value);
                Reflect.setField(inst, field, fieldInst);
            }
            else
            {
                Reflect.setField(inst, field, value);
            }
        }
    }
}