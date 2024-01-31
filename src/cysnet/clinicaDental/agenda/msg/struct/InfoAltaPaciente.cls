Class cysnet.clinicaDental.agenda.msg.struct.InfoAltaPaciente Extends (%SerialObject, %XML.Adaptor)
{

Property paciente As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse;

Property admision As cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse;

Property fechaAlta As %TimeStamp;

Storage Default
{
<Data name="InfoAltaPacienteState">
<Value name="1">
<Value>paciente</Value>
</Value>
<Value name="2">
<Value>admision</Value>
</Value>
<Value name="3">
<Value>fechaAlta</Value>
</Value>
</Data>
<State>InfoAltaPacienteState</State>
<StreamLocation>^cysnet.clin8AF.InfoAltaPacD889S</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
