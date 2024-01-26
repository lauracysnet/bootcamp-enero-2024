Class cysnet.clinicaDental.agenda.msg.ExisteAdmisionResponse Extends Ens.Response
{

Property existe As %Boolean;

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="ExisteAdmisionResponseDefaultData">
<Subscript>"ExisteAdmisionResponse"</Subscript>
<Value name="1">
<Value>existe</Value>
</Value>
<Value name="2">
<Value>exito</Value>
</Value>
<Value name="3">
<Value>error</Value>
</Value>
</Data>
<DefaultData>ExisteAdmisionResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
