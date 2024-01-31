Class cysnet.clinicaDental.agenda.msg.AltaPacienteResponse Extends Ens.Response
{

Property mensaje As %String(MAXLEN = "");

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="AltaPacienteResponseDefaultData">
<Subscript>"AltaPacienteResponse"</Subscript>
<Value name="1">
<Value>mensaje</Value>
</Value>
<Value name="2">
<Value>exito</Value>
</Value>
<Value name="3">
<Value>error</Value>
</Value>
</Data>
<DefaultData>AltaPacienteResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
