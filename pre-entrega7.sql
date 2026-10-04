
CREATE ROLE analista_datos_gr NOLOGIN;

GRANT SELECT ON ALL TABLES IN SCHEMA public
TO analista_datos_gr;

CREATE ROLE cientifico_datos_gr NOLOGIN;

GRANT analista_datos_gr TO cientifico_datos_gr;

GRANT CREATE ON SCHEMA public
TO cientifico_datos_gr;

CREATE USER analista_junior_01
WITH PASSWORD 'AnalistaData_2026!';

CREATE USER head_data_science
WITH PASSWORD 'HeadData_2026!';

GRANT analista_datos_gr TO analista_junior_01;

GRANT cientifico_datos_gr TO head_data_science;

REVOKE DELETE ON TABLE ventas
FROM analista_datos_gr;

SELECT
    rolname,
    rolcanlogin
FROM pg_roles
WHERE rolname IN (
    'analista_datos_gr',
    'cientifico_datos_gr',
    'analista_junior_01',
    'head_data_science'
)
ORDER BY rolname;

SELECT
    member.rolname AS usuario,
    role.rolname AS rol_asignado
FROM pg_auth_members
JOIN pg_roles AS role
    ON pg_auth_members.roleid = role.oid
JOIN pg_roles AS member
    ON pg_auth_members.member = member.oid
WHERE member.rolname IN (
    'analista_junior_01',
    'head_data_science',
    'cientifico_datos_gr'
)
ORDER BY member.rolname;

SELECT
    grantee,
    table_schema,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'analista_datos_gr'
  AND table_schema = 'public'
ORDER BY table_name, privilege_type;
