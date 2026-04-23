import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/providers/auth_provider.dart';
import '../../../../app/router/routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // Claves globales y controladores
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Se liberan los recursos de los controladores cuando el widget se elimina
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Método que inicia sesión
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  // Método que construye la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);

    // Redirige cuando el login es exitoso
    ref.listen(authProvider, (_, next) {
      if (next.value == AuthStatus.authenticated) {
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      body: SafeArea( // Se utiliza SafeArea para evitar que el contenido se superponga con elementos de la interfaz de usuario
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título
                Text('Hola de nuevo 👋',
                    style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8),
                
                // Descripción
                Text('Ingresá para ver tu biblioteca.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    )),
                const SizedBox(height: 40),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || !v.contains('@') ? 'Email inválido' : null,
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) => v == null || v.length < 6
                      ? 'Mínimo 6 caracteres'
                      : null,
                ),
                const SizedBox(height: 32),

                // Error
                if (authState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Credenciales incorrectas. Intentá de nuevo.',
                      style: TextStyle(
                          color: theme.colorScheme.error),
                    ),
                  ),

                // Botón
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: authState.isLoading ? null : _submit,
                    child: authState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Ingresar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}