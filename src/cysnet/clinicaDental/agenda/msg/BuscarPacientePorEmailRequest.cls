Class cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailRequest Extends Ens.Request
{

Property email As %String;

Storage Default
{
<Data name="BuscarPacientePorEmailRequestDefaultData">
<Subscript>"BuscarPacientePorEmailRequest"</Subscript>
<Value name="1">
<Value>email</Value>
</Value>
</Data>
<DefaultData>BuscarPacientePorEmailRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
