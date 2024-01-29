Class cysnet.clinicaDental.agenda.msg.struct.InfoModificarCita Extends (%SerialObject, %XML.Adaptor)
{

Property cita As cysnet.clinicaDental.agenda.msg.TraerCitaResponse;

Property paciente As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse;

Storage Default
{
<Data name="InfoModificarCitaState">
<Value name="1">
<Value>cita</Value>
</Value>
<Value name="2">
<Value>paciente</Value>
</Value>
</Data>
<State>InfoModificarCitaState</State>
<StreamLocation>^cysnet.clin8AF.infoModific109FS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
