Class cysnet.clinicaDental.agenda.msg.BuscarPacientePorEmailResponse Extends Ens.Response
{

Property ID As %Integer;

Property nombre As %String;

Property apellidos As %String;

Property email As %String;

Property permiteNotificaciones As %Boolean;

Property baja As %Boolean;

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="BuscarPacientePorEmailResponseDefaultData">
<Subscript>"BuscarPacientePorEmailResponse"</Subscript>
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>nombre</Value>
</Value>
<Value name="3">
<Value>apellidos</Value>
</Value>
<Value name="4">
<Value>email</Value>
</Value>
<Value name="5">
<Value>permiteNotificaciones</Value>
</Value>
<Value name="6">
<Value>baja</Value>
</Value>
<Value name="7">
<Value>exito</Value>
</Value>
<Value name="8">
<Value>error</Value>
</Value>
</Data>
<DefaultData>BuscarPacientePorEmailResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
