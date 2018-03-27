<template>
    <div class="admin-container">
        <div class="admin-page-content">
        </div>

    </div>
</template>

<script>

export default {
    middleware: ['logged', 'admin'],
    layout: "admin"
};
</script>
