Class cysnet.clinicaDental.agenda.msg.AltaCitasResponse Extends Ens.Response
{

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="AltaCitasResponseDefaultData">
<Subscript>"AltaCitasResponse"</Subscript>
<Value name="1">
<Value>exito</Value>
</Value>
<Value name="2">
<Value>error</Value>
</Value>
</Data>
<DefaultData>AltaCitasResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
