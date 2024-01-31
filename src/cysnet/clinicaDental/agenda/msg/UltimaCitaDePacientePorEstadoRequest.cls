Class cysnet.clinicaDental.agenda.msg.UltimaCitaDePacientePorEstadoRequest Extends Ens.Request
{

Property idPaciente As %Integer;

Property codEstado As %Integer;

Storage Default
{
<Data name="UltimaCitaDePacientePorEstadoRequestDefaultData">
<Subscript>"UltimaCitaDePacientePorEstadoRequest"</Subscript>
<Value name="1">
<Value>idPaciente</Value>
</Value>
<Value name="2">
<Value>codEstado</Value>
</Value>
</Data>
<DefaultData>UltimaCitaDePacientePorEstadoRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
