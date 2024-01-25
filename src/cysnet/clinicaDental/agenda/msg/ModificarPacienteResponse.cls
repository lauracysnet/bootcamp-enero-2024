Class cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse Extends Ens.Response
{

Property mensaje As %String(MAXLEN = "");

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="ModificarPacienteResponseDefaultData">
<Subscript>"ModificarPacienteResponse"</Subscript>
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
<DefaultData>ModificarPacienteResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
