Class cysnet.clinicaDental.agenda.msg.struct.InfoAdmision Extends (%SerialObject, %XML.Adaptor)
{

Property paciente As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse;

Property admision As cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse;

Storage Default
{
<Data name="InfoAdmisionState">
<Value name="1">
<Value>paciente</Value>
</Value>
<Value name="2">
<Value>admision</Value>
</Value>
</Data>
<State>InfoAdmisionState</State>
<StreamLocation>^cysnet.clinica8AF.InfoAdmisionS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
