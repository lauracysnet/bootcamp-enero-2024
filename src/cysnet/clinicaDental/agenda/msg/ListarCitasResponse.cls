Class cysnet.clinicaDental.agenda.msg.ListarCitasResponse Extends Ens.Response
{

Property citas As list Of cysnet.clinicaDental.agenda.msg.struct.infoCita;

Property mensaje As %String(MAXLEN = "");

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="ListarCitasResponseDefaultData">
<Subscript>"ListarCitasResponse"</Subscript>
<Value name="1">
<Value>citas</Value>
</Value>
<Value name="2">
<Value>mensaje</Value>
</Value>
<Value name="3">
<Value>exito</Value>
</Value>
<Value name="4">
<Value>error</Value>
</Value>
</Data>
<DefaultData>ListarCitasResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
