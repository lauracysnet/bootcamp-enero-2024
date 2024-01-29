Class cysnet.clinicaDental.agenda.msg.struct.InfoAltaPaciente Extends (%SerialObject, %XML.Adaptor)
{

Property idPaciente As %Integer;

Property nombre As %String;

Property apellido As %String;

Property idAdmision As %Integer;

Property fechaAdmision As %TimeStamp;

Property fechaAlta As %TimeStamp;

Storage Default
{
<Data name="InfoAltaPacienteState">
<Value name="1">
<Value>idCita</Value>
</Value>
<Value name="2">
<Value>descCita</Value>
</Value>
<Value name="3">
<Value>fechaCita</Value>
</Value>
<Value name="4">
<Value>idPaciente</Value>
</Value>
<Value name="5">
<Value>nombre</Value>
</Value>
<Value name="6">
<Value>apellido</Value>
</Value>
<Value name="7">
<Value>baja</Value>
</Value>
<Value name="8">
<Value>idAdmision</Value>
</Value>
<Value name="9">
<Value>fechaAdmision</Value>
</Value>
<Value name="10">
<Value>fechaAlta</Value>
</Value>
</Data>
<State>InfoAltaPacienteState</State>
<StreamLocation>^cysnet.clin8AF.InfoAltaPacD889S</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
