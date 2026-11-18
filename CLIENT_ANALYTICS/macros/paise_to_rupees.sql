-- Reusable business rule: convert an amount in paise to rupees.
-- Change it here once and every model that uses it picks up the change.
{% macro paise_to_rupees(column_name) %}
    ({{ column_name }} / 100)::number(16, 2)
{% endmacro %}
