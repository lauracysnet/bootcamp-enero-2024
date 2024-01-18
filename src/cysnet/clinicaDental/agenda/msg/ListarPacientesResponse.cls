Class cysnet.clinicaDental.agenda.msg.ListarPacientesResponse Extends Ens.Response
{

Property pacientes As list Of cysnet.clinicaDental.agenda.data.Pacientes;

Property mensaje As %String(MAXLEN = "");

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="ListarPacientesResponseDefaultData">
<Subscript>"ListarPacientesResponse"</Subscript>
<Value name="1">
<Value>pacientes</Value>
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
<DefaultData>ListarPacientesResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
