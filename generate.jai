#import "Bindings_Generator";
#import "Compiler";
#import "Basic";
#import "File";
#import "File_Utilities";

#run {
   set_build_options_dc(.{ do_output = false });

   using options: Generate_Bindings_Options;
   array_add(*source_files, "source/include/spirv/unified1/spirv.h");
   array_add(*source_files, "source/include/spirv/unified1/GLSL.std.450.h");
   visitor_with_data = SpirvHeadersVisitor;
   array_add(*extra_clang_arguments, "-x", "c", "-DSPV_ENABLE_UTILITY_CODE");
   outputFilename := "bindings.jai";
   ok := generate_bindings(options, outputFilename);
   if (!ok) {
      compiler_set_workspace_status(.FAILED);
   }
}

SpirvHeadersVisitor :: (decl: *Declaration, parent_decl: *Declaration, user_data: *void) -> Declaration_Visit_Result {
   return .RECURSE;
}
